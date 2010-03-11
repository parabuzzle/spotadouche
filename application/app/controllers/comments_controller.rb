class CommentsController < ApplicationController
  before_filter :protect, :only => [:new, :edit]
  before_filter :protect_sensitive, :only => [:edit]
  
  def new
    @title = "Spot a Douche - New Comment"
    @photo = Photo.find(params[:photoid])
    if request.post?
      c = @photo.comments.new(params[:comment])
      c.ip = request.remote_ip
      c.user_id = session[:user]
      c.save
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
  
  def protect_sensitive
    user = User.find(session[:user])
    if user.id == Comment.find(params[:id]).user_id || user.admin
      return true
    else
      session[:protected_page] = request.request_uri
      flash[:notice] = "i can't do that dave... you can only edit your own stuff"
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
end
