class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @title = "Spot a Douche"
    #@photos = Photo.find(:all, :order=> 'created_at desc', :conditions => "status >= 5")
    @photos = Photo.paginate :page => params[:page], :order => 'created_at DESC', :conditions => "status >= 5", :per_page => 5
  end
  
end
