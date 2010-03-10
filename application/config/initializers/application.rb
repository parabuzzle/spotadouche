#This file loads extra envrionment stuff

#Add pretty date format
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:pretty => "%B %d, %Y")
