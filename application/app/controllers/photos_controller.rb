class PhotosController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only =>[:new, :create, :edit]
  before_filter :protect_sensitive, :only =>[:edit]
  
  def new
    @title = "Spot a Douche - Upload your image"
    @user = User.find(session[:user])
    @photo = @user.photos.new(params[:photo])
  end
  
  def edit
    @photo = Photo.find(params[:id])
    unless params[:pp] then @@defaultpp = 10 else pp = params[:pp] end
    @comments = @photo.comments.paginate :page => params[:page], :order => 'created_at DESC', :per_page => pp
    @user = @photo.user
    @title = "Spot a Douche - #{@photo.title}"
    if request.post?
      @photo.update_attributes(params[:photo])
      redirect_to :action => 'show', :id => params[:id]
    end
  end
  def show
    @photo = Photo.find(params[:id])
    @user = @photo.user
    unless params[:pp] then @@defaultpp = 10 else pp = params[:pp] end
    @comments = @photo.comments.paginate :page => params[:page], :order => 'created_at DESC', :per_page => pp
    @title = "Spot a Douche - #{@photo.title}"
  end
  
  def create
    @title = "Spot a Douche - Upload your image"
    @user = User.find(session[:user])
    @photo = @user.photos.new(params[:photo])
    @photo.ip = request.remote_ip
    if @photo.save
      Mail.deliver_newphoto(@photo, @user, request.host)
      flash[:notice] = 'Your photo has been submitted for approval. It should be available shortly.'
      redirect_to :controller => 'site', :action => 'index'    
    else
      render :action => :new
    end
  end
  
  def feed
    @photos = Photo.find(:all, :limit => 10, :order => "created_at DESC", :conditions => "status >=5 ")
    render :template => false
  end
  
  private
  
  def protect_sensitive
    user = User.find(session[:user])
    photo = Photo.find(params[:id])
    if user.id == photo.user_id || user.admin
      return true
    else
      session[:protected_page] = request.request_uri
      flash[:error] = "I'm sorry, you are not authorized to view that page."
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
end
