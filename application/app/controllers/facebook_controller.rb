class FacebookController < ApplicationController
  def index
    @title = "Spot a Douche - Facebook"
    render :template => false
  end
end
