class UsersController < ApplicationController
  before_filter :protect_sensitive, :only => [:edit]
  before_filter :protect, :only =>[:index, :edit]
  # say something nice, you goof!  something sweet.
  def index
    @title="Spot a Douche - User Dashboard"
    @user = User.find(session[:user])
    @prefs = @user.pref
    @live = Photo.find(:all, :conditions => "user_id = #{@user.id} and status >= 5")
    if @prefs.about.nil? || @prefs.about.empty?
      if flash[:notice].nil? 
        flash[:notice] = "You don't have any \"about me information\"<br/> <a href='/user/edit/#{@user.id}'>Click here</a> to add something now!</a>"
      end
    end
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

  def profile
    @user = User.find_by_login(params[:login])
    @photos = Photo.find(:all, :conditions => "user_id = #{@user.id}")
    @live = Photo.find(:all, :conditions => "user_id = #{@user.id} and status >= 5")
    @title="Spot a Douche - #{@user.login}'s Profile"
  end


  def login
    @title="Spot a Douche - Login"
    if params[:facebox] == 'true'
      render :template => false
    end
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/users', :action => 'index')
      flash[:notice] = "You have been logged in. Welcome back"
    end
  end
  
  def submit_email_gen
    if request.post?
      @user = User.find(session[:user])
      @user.pref.make_submission_email
      @user.pref.save
      flash[:notice] = "Submission Email has been regenerated"
      redirect_to :action => 'index'
    else
      redirect_to :action => 'index'
    end
  end
  
  def edit
    @title="Spot a Douche - Edit"
    if params[:id].nil? then params[:id] = session[:user] end
    id = params[:id]
    @user = User.find(id)
    @pref = @user.pref
    return unless request.post?
    @user.update_attributes(params[:user])
    @pref.update_attributes(params[:pref])
    self.current_user = @user
    redirect_back_or_default(:controller => '/users', :action => 'index')
    flash[:notice] = "Updated User Settings"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def signup
    @title="Spot a Douche - Signup"
    @user = User.new(params[:user])
    if params[:facebox] == 'true'
      render :template => false
    end
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/users', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    @title="Spot a Douche - Logout!"
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => 'site', :action => 'index')
  end
  
  private 
  
  def protect_sensitive
    user = User.find(session[:user])
    if user.id == params[:id].to_i || user.admin
      return true
    else
      session[:protected_page] = request.request_uri
      flash[:notice] = "I'm sorry, you aren't authorized to view that page."
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
  
end
