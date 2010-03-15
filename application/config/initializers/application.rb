#This file loads extra envrionment stuff

#init site props
SITE_PROPS = YAML::load(File.open("#{RAILS_ROOT}/config/siteprops.yml"))

#Add pretty date format
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:pretty => "%B %d, %Y")

#Email Server Settings
ActionMailer::Base.smtp_settings = { 
                                        :address => 'util.slh.madhattermm.com', 
                                        :port => '587', 
                                        :domain => 'spotadouche.com', 
                                        :user_name => "spotter@spotadouche.com",
                                        :password => "sp0tt3r",
                                        :authentication => :plain
                                        }
