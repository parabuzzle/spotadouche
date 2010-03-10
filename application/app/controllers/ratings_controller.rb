class RatingsController < ApplicationController
  
  def rate
    @photo = Photo.find(params[:id])
    if request.post?
      unless session[:user].nil?
        user = User.find(session[:user])
        @photo.rate(params[:rating].to_i, user)
      end
    end
  end
  
  
end
