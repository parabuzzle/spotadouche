module SiteHelper
  def blog_rss
    blogrss = "http://spotadouche.wordpress.com/feed/"
    cachedir = RAILS_ROOT + '/cache'
    FileUtils.mkdir_p(cachedir) unless File.directory?(cachedir)
    file = "#{cachedir}/blog.db"
    
    if File.exist?(file) and File.mtime(file)>Time.now - SITE_PROPS['admin']['blogcache']
      logger.debug "blog rss cache file is valid... using it"
      content = File.new(file)
    else
      logger.debug "blog rss cache file is old... refreshing"
       # raw content of rss feed will be loaded here
      open(blogrss) do |s| content = s.read end
      f = File.new(file,"w")
      f.write(content)
    end
    return RSS::Parser.parse(content, false)
  end  
end

