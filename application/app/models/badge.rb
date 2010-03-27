class Badge < ActiveRecord::Base
  belongs_to :user
  
  
  def all
    badges = []
    #get static badges
    self.attributes.each do |b|
      unless b[0].match(/at$/) || b[0].match(/id$/) || b[0] == "id"
        if b[1]
          badges << b[0] + '_badge.png'
        end
      end
    end
    #get point based badges
    #score = self.user.score
    #if score >=1000
    #  badges << '1k_badge.png'
    #end
    #if score >=10000
    #  badges << '10k_badge.png'
    #end
    #if score >=100000
    #  badges << '100k_badge.png'
    #end
    #if score >=1000000
    #  badges << '1m_badge.png'
    #end
    return badges
  end
  
  
end
