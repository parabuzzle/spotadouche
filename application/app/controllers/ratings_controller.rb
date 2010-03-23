class RatingsController < ApplicationController
  
  def rate
    @photo = Photo.find(params[:id])
    if request.post?
      unless session[:user].nil?
        user = User.find(session[:user])
        user.add_points(User::POINTS_RATING) unless @photo.rated_by?(user)
        @photo.rate(params[:rating].to_i, user)
      end
    end
  end
  
  
end
