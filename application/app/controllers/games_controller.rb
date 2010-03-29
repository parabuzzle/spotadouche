class GamesController < ApplicationController
  
  template = "games"
  
  def index
    @title = "Spot a Douche - Games"
  end
  
  def dond
    @title = "Spot a Douche - Douche or Not a Douche"
    @photo = Photo.find(:first, :order => 'RAND()', :conditions => "status >= 5")
    @last = Photo.find(params[:last]) unless params[:last].nil?
    @user = User.find(session[:user]) unless session[:user].nil?
    return unless request.post?
    if params[:vote] != nil
      unless @user.nil?
        b = @user.badge
        unless b.dond? == true
          b.dond = true
          b.save
          if @user.pref.system_mail?
            Mail.deliver_newbadge(@user, 'You got a badge for your playing the Douche or Not a Douche game') unless @user.bouncing?
          end
        end
      end
      if params[:vote] == "up"
        @last.vote_up!
      elsif params[:vote] == "down"
        @last.vote_down!
      end
      @last.reload
    end
  end
  
  def are_you_a_douche
    @title = "Spot a Douche - Are you a Douche?"
    @user = User.find(session[:user]) unless session[:user].nil?
    session.store('survey_score', {'start' =>  0}) if params[:q].nil?
    if params[:q].nil? then @page = 'games/survey/start' else @page = 'games/survey/' + params[:q] end
    if request.post?
      session[:survey_score].store(params[:q], params[:s])
    end      
  end
  
  
end
