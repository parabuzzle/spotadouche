class AdminController < ApplicationController
  
  before_filter :protect, :except => [:status]
  @@defaultpp = 10
  
  def index
    @title = "Spot a Douche - Admin Dashboard"
    @pending = Photo.find(:all, :conditions => "status = 0")
    @ucount = User.count
    @active = Photo.find(:all, :conditions => "status >= 5")
    @deleted = Photo.find(:all, :conditions => "status = 2")
    @rejected = Photo.find(:all, :conditions => "status = 1")
  end
  
  def rejects
    @title = "Spot a Douche - Rejected Photos"
    unless params[:pp] then @@defaultpp = 10 else pp = params[:pp] end
    @photos = Photo.paginate :page => params[:page], :order => 'created_at DESC', :conditions => "status = 1", :per_page => pp
  end
  def deleted
    @title = "Spot a Douche - Deleted Photos"
    unless params[:pp] then @@defaultpp = 10 else pp = params[:pp] end
    @photos = Photo.paginate :page => params[:page], :order => 'created_at DESC', :conditions => "status = 2", :per_page => pp
  end
  
  def pending
    @title = "Spot a Douche - Photo Moderation"
    unless params[:pp] then pp = 10 else pp = params[:pp] end
    @pending = Photo.paginate :page => params[:page], :conditions => "status = 0", :per_page => pp
  end
  
  def updatestatus
    @photo = Photo.find(params[:id])
    if request.post?
      @photo.status = params[:status].to_i
      @photo.created_at = Time.now
      @photo.forceup = params[:forceup]
      save = @photo.save
      if @photo.status >= 5
        b = @photo.user.badge
        unless b.first_photo? == true
          b.first_photo = true
          b.save
          if @photo.user.pref.system_mail?
            Mail.deliver_newbadge(@photo.user, 'You got a badge for your first photo being approved.') unless @photo.user.bouncing?
          end
        end
        @photo.user.add_points(User::POINTS_PHOTO_APPROVED)
        if @photo.user.pref.system_mail?
          Mail.deliver_photo_approved(@photo) unless @photo.user.bouncing?
        end
      else
        @photo.user.rm_points(User::POINTS_PHOTO_REJECTED)
      end
      if save != true
        flash[:error] = "there were errors updating the status<br/>System says: #{@photo.errors.full_messages}<br/>You may want to force delete this photo"
      else
        @photo.reload
        if params[:forceup] == true
          flash[:error] = "Photo has been force updated..."
        end
      end
    end
  end
  
  def users
    @title = "Spot a Douche - User Moderation"
    if request.post?
      @user = User.find(params[:id])
      @user.admin = params[:user][:admin]
      @user.save
      redirect_to :action => "users"
    else
      unless params[:pp] then pp = 10 else pp = params[:pp] end
      @users = User.paginate :page => params[:page], :order => 'id', :per_page => pp
    end
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
  
  def status
    render :template => false
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
       flash[:error] = "I can't do that dave... You must be an admin to do that"
       redirect_to :controller => "site", :action => "index"
       return false
     end
   end
  
end
