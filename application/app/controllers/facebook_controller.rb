class FacebookController < ApplicationController
  def index
    @title = "Spot a Douche - Facebook"
    @photo = Photo.find(:first, :order => 'RAND()')
    render :template => false
  end
end
