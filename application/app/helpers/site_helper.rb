module SiteHelper
  def blog_rss
    blogrss = "http://spotadouche.wordpress.com/feed/"
    cachedir = RAILS_ROOT + '/cache'
    FileUtils.mkdir_p(cachedir) unless File.directory?(cachedir)
    file = "#{cachedir}/blog.yml"
    
    if File.exist?(file) and File.mtime(file)>Time.now - 0 #cache for 5 minutes
      logger.debug "blog rss cache file is valid... using it"
      content = YAML::load(File.open(file))
    else
      logger.debug "blog rss cache file is old... refreshing"
       # raw content of rss feed will be loaded here
      open(blogrss) do |s| content = s.read end
      f = File.new(file,"w")
      f.write(YAML::dump(content))
    end
    return RSS::Parser.parse(content, false)
  end  
end

