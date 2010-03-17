class FacebookController < ApplicationController
  def index
    @title = "Spot a Douche - Facebook"
    @photo = Photo.find(:first, :order => 'RAND()', :conditions => "status >= 5")
    #@photo = Photo.last
    if params[:vote] != nil
      if params[:vote] == "up"
        @photo.vote_up!
      elsif params[:vote] == "down"
        @photo.vote_down!
      end
      @photo = Photo.find(params[:last]) unless params[:last].nil?
    end
    render :template => false
  end
end
