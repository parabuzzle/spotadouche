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
    if @photo.save
      flash[:notice] = 'Your douche photo has been submitted. Upon approval your image will be available for the masses'
      redirect_to :controller => 'site', :action => 'index'    
    else
      render :action => :new
    end
  end
  
  private
  
  def protect_sensitive
    user = User.find(session[:user])
    photo = Photo.find(params[:id])
    if user.id == photo.user_id || user.admin
      return true
    else
      session[:protected_page] = request.request_uri
      flash[:notice] = "i can't do that dave... you can only edit your own stuff"
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
end
