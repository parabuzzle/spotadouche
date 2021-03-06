class FacebookController < ApplicationController
  ensure_application_is_installed_by_facebook_user
  
  def index
    @title = "Spot a Douche - Facebook"
    @photo = Photo.find(:first, :order => 'RAND()', :conditions => "status >= 5")
    @last = Photo.find(params[:last]) unless params[:last].nil?
    if params[:vote] != nil
      if params[:vote] == "up"
        @last.vote_up!
      elsif params[:vote] == "down"
        @last.vote_down!
      end
      @last.reload
    end
    render :template => false
  end
  
  def facebook
    @title = "Spot a Douche - Welcome"
    redirect_to :controller => "site", :action => "index"
  end
    
end
