class FacebookController < ApplicationController
  def index
    @title = "Spot a Douche - Facebook"
    @photo = Photo.find(:first, :order => 'RAND()', :conditions => "status >= 5")
    #@photo = Photo.last
    if request.post?
      if params[:vote] == "up"
        @photo.vote_up!
      elsif params[:vote] == "down"
        @photo.vote_down!
      end
      params[:last] = @photo.id
    end
    @last = Photo.find(params[:last]) unless params[:last].nil? 
    render :template => false
  end
end
