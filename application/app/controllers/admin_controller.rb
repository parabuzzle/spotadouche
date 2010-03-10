class AdminController < ApplicationController
  
  before_filter :protect
  
  
  def index
    @title = "Spot a Douche - Admin Dashboard"
    @pending = Photo.find(:all, :conditions => "status = 0")
    @ucount = User.count
    @active = Photo.find(:all, :conditions => "status >= 5")
    @deleted = Photo.find(:all, :conditions => "status = 2")
  end
  
  def pending
    @title = "Spot a Douche - Photo Moderation"
    @pending = Photo.find(:all, :conditions => "status = 0")
  end
  
  def updatestatus
    @photo = Photo.find(params[:id])
    if request.post?
      @photo.status = params[:status]
      @photo.save
      @photo.reload
      redirect_to :action => 'pending'
    end
  end
  
  def users
    @title = "Spot a Douche - User Moderation"
    @users = User.all
  end
  
  def updateuser
    @user = User.find(params[:id])
    if request.post?
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.fbuid} updated"
        redirect_to :action => "index"
      else
        flash[:error] = "Error updating user"
      end
    end
  end
  
  
  private
  
  def admin?
    if session[:user].nil?
      return false
    else
      return User.find(session[:user]).admin
    end
    return false
  end
  
  def protect
     unless admin?
       session[:protected_page] = request.request_uri
       flash[:notice] = "i can't do that dave... you must be an admin"
       redirect_to :controller => "site", :action => "index"
       return false
     end
   end
  
end
