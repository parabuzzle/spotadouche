# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  
  def user?
    @user = User.find(session[:user])
  end

  def admin?
    unless user?.nil?
      return user?.admin
    end
    return false
  end

  # Check if user is logged in and login or create as needed
  #def logged_in?
  #  if cookies[:user]
  #    return true
  #  else
  #    return false
  #  end
  #end
  
  #def logged_in?
  #  # check if there is a fbconnect session
  #  unless facebook_session
  #    # no fbconnect session means the user is not logged in
  #    if cookies[:fb]
  #      logger.info("deleting cookies for user with missing fb session - fbuid: #{cookies[:fb]}")
  #      #delete any user cookie that may exist
  #      logout!
  #    end
  #    return false
  #  else
  #    if cookies[:fb]
  #      #cookie exists
  #      fb = cookies[:fb]
  #      #check that the cookie data and the session data match
  #      if facebook_session.user.uid.to_i == fb.to_i
  #        #data matches - user is logged in
  #        logger.debug("fb session and cookie data match. user #{facebook_session.user.uid} logged in")
  #        return true
  #      else
  #        # data doesn't match, delete existing cookie and relogin
  #        logger.warn("session and cookie don't match. executing re-login for #{facebook_session.user.uid} (session #{facebook_session.user.uid} : cookie #{fb})")
  #        logout!
  #        return login!(facebook_session.user.uid)
  #      end
  #    else
  #      #no cookie - log the user in
  #      return login!(facebook_session.user.uid)
  #    end
  #  end
  #end
  
  # Create a local user entry
  def create_local_user(data)
    user = User.new(data)
    return user.save
  end
  
  #def admin?
  #  unless cookies[:fb].nil?
  #    user = User.find_by_fbuid(cookies[:fb])
  #    unless user.nil?
  #      return User.find_by_fbuid(cookies[:fb]).admin
  #    else
  #      return false
  #    end
  #  else
  #    return false
  #  end
  #end
  
  # create the login cookie for the site
  #def login!(fbuid)
  #  cookie_expiration = 2.weeks.from_now
  #  if User.find_by_fbuid(fbuid)
  #    logger.debug("user in database. setting cookie and loggin in #{fbuid}")
  #    cookies[:fb] = {:value => fbuid, :expires => cookie_expiration}
  #    return true
  #  else
  #    user = {'fbuid' => fbuid}
  #    if create_local_user(user)
  #      logger.debug("user not in database, creating and loggin in #{fbuid}")
  #      cookies[:fb] = {:value => fbuid, :expires => cookie_expiration}
  #      return true
  #    else
  #      #error in login
  #      return false
  #    end
  #  end
  #end
  
  # remove local cookies
  #def logout!
  #  logger.debug("removed all user cookies")
  #  return cookies.delete(:fb)
  #end
  
  
  #Creates the facebook login button
  def fb_login(uri='/', msg='Login with Facebook')
    tag = "<fb:login-button v=\"2\" size=\"medium\" onlogin=\"window.location.reload(true);\">#{msg}</fb:login-button>"
    return tag
  end
    
  def fbuid
    return cookies[:fb].to_i
  end
  
  # insert facebook javascript tag
  def facebook_connect_javascript
    tag = "<script src=\"http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US\" type=\"text/javascript\"></script>"
    return tag
  end
  
  # init the facebook javascript with the proper api key
  def facebook_connect_init
    tag = "<script type=\"text/javascript\">FB.init(\"#{FACEBOOKER['api_key']}\");</script>"
    return tag
  end


  def reldate(date)
      #Makes utc dates relative to now.
      idate = date.to_i
      now = Time.now.to_i
      n = now - idate

      if n <= 60 #less than a minute
        return "#{n} seconds ago"

      elsif n < 3600 #less than an hour
        if n < 120
          return "about a minute ago"
        else
          n = n/60
          return "#{n} minutes ago"
        end

      elsif n < 86400 #less than a day
        if n < 7200
          return "about an hour ago"
        else
          n = n/3600
          return "#{n} hours ago"
        end

      elsif n < 604800 #less than a week
        if n < 172800
          return "about a day ago"
        else
          n = n/86400
          return "#{n} days ago"
        end

      elsif n < 2419200 #less than a month
        if n < 1209600
          return "about a week ago"
        else
          n = n/604800
          return "#{n} weeks ago"
        end

      elsif n < 31449600 #less than a year
        if n < 4838400
          return "about a month ago"
        else
          n = n/2419200
          return "#{n} months ago"
        end

      elsif n >= 31449600 #Greater than a year
        if 62899200
          return "last year"
        else
          n = n/31449600
          return "#{n} years ago"
        end
      else
        return date
      end
    end


end
