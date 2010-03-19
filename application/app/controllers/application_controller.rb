# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  #Make a tracking cookie
  before_filter :ensure_tracking_cookie, :except => [:status]
  before_filter :page_tracker, :except => [:status]
  before_filter :login_from_cookie
  
  # Load facebook session data
  before_filter :create_facebook_session
  helper_method :facebook_session
  #before_filter :guarantee_facebook_session
  
  #load cookies in to helpers
  helper_method :cookies
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def page_tracker
    session[:current_page] = request.request_uri
  end
  
  # Sets a tracking cookie
  def ensure_tracking_cookie
    cookie_expiration = 10.years.from_now
    version = 'v2'
    if cookies[:b].nil?
      logger.info("no tracking cookie found. setting cookie.")
      data = "#{version}%%tagged"
      cookies[:b] = {:value => data, :expires => cookie_expiration}
    end
  end
  
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:error] = "I'm sorry. You must be logged in to access that section of the site."
      #redirect_to :protected_page unless :protected_page.nil?
      redirect_to :controller => "users", :action => "login"
      return false
    end
  end
  
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :controller => 'site', :action => 'index'
    end
  end
  
  # redirects in the typical case
  # before_filter :ensure_authenticated_to_facebook
  
  #def guarantee_facebook_session
  #  begin
  #    # try to trigger the sessionexpired exception, this is the  "cheapest" API call I could find
  #    @facebook_session.post('facebook.users.getLoggedInUser', :session_key => @facebook_session.session_key)
  #    # session is valid, catch someone trying to steal it
  #    fb_user_id = params[:fb_sig_canvas_user] || params[:fb_sig_user]
  #    raise if fb_user_id && fb_user_id.to_i != @facebook_session.user.id
  #  rescue
  #    return facebook_session_expired
  #  end
  #end
  #def facebook_session_expired
  #  #reset_session # clear_fb_cookies!, nuke their rails/rack session, yadda
  #  facebook_session = nil
  #end
  
  
end
