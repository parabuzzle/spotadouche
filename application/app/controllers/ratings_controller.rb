class RatingsController < ApplicationController
  
  def rate
    @photo = Photo.find(params[:id])
    if request.post?
      unless session[:user].nil?
        user = User.find(session[:user])
        b = user.badge
        unless b.rated? == true
          b.rated = true
          b.save
          if user.pref.system_mail?
            Mail.deliver_newbadge(user, 'You got a badge for rating your first douche.') unless user.bouncing?
          end
        end
        user.add_points(User::POINTS_RATING) unless @photo.rated_by?(user)
        @photo.rate(params[:rating].to_i, user)
      end
    end
  end
  
  
end
