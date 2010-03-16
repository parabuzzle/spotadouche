require 'rss/1.0'
require 'rss/2.0'

class RSS::Rss
  def to_html
    max_description_length = 150
    max = 4
    html = ""
    a = 0
    channel.items.each do |i|
      if a < max
        html << "<div class='bloglink'><a href='#{i.link}' target='blank'>#{i.title}</a></div>"
        html << "<div class='blogdate'>#{i.date.strftime("%m/%d/%Y")}</div>" if i.date
        desc_text = i.description.gsub(/<[^>]+>/,"").squeeze(" ").strip
        if desc_text.length > max_description_length
          desc_text = desc_text[0,max_description_length] + "&hellip;"
        else
          desc_text = i.description
        end
        html << "<div class='blogitem'><a href='#{i.link}' target='blank'>#{desc_text}</a></div>"
        html << "<div class='sep'></div>"
        a+=1
      else
        break
      end
    end

    html << ""
    html
  end
end