class PhotosController < ApplicationController
  include ApplicationHelper
  before_filter :protect, :only =>[:new, :create]
  
  def new
    @title = "Spot a Douche - Upload your image"
    @user = User.find(session[:user])
    @photo = @user.photos.new(params[:photo])
  end
  
  def edit
    @photo = Photo.find(params[:id])
    @comments = @photo.comments
    @user = @photo.user
    @title = "Spot a Douche - #{@photo.title}"
    if request.post?
      @photo.update_attributes(params[:photo])
      redirect_to :action => 'show', :id => params[:id]
    end
  end
  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments
    @user = @photo.user
    @title = "Spot a Douche - #{@photo.title}"
    if request.post?
      c = @photo.comments.new(params[:comment])
      c.user_id = @user.id
      c.save
    end
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
  
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "i can't do that dave... you must be logged in first"
      redirect_to :controller => "site", :action => "index"
      return false
    end
  end
  
  
end
