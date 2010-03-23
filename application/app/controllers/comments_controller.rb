class CommentsController < ApplicationController
  before_filter :protect, :only => [:new, :edit]
  before_filter :protect_sensitive, :only => [:edit]
  
  def new
    @title = "Spot a Douche - New Comment"
    @photo = Photo.find(params[:photoid])
    if request.post?
      c = @photo.comments.new(params[:comment])
      c.ip = request.remote_ip
      unless session[:user].nil?
        c.user_id = session[:user]
        c.save
        @user.find(c.user_id).add_points(User::POINTS_COMMENT)
        Mail.deliver_new_comment(@photo) unless @photo.user.bouncing?
      end
      redirect_to :action => "show", :controller => 'photos', :id => params[:photoid]
    end
  end
  
  def edit
    @title = "Spot a Douche - Edit your Comment"
    @comment = Comment.find(params[:id])
    if request.post?
      @comment.update_attributes(params[:comment])
    end
  end
  
  def show
    @title = "Spot a Douche - Comments"
    @photo = Photo.find(params[:id])
    unless params[:pp] then @@defaultpp = 10 else pp = params[:pp] end
    @comments = @photo.comments.paginate :page => params[:page], :order => 'created_at DESC', :per_page => pp
  end
  
  private
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:error] = "I'm sorry. You must be logged in to leave comments."
      return false
    end
  end
  
  def protect_sensitive
    user = User.find(session[:user])
    if user.id == Comment.find(params[:id]).user_id || user.admin
      return true
    else
      session[:protected_page] = request.request_uri
      flash[:error] = "I'm sorry, you are not authorized to edit that page."
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
end
