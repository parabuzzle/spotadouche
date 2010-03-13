class SiteController < ApplicationController
  include ApplicationHelper
  
  def index
    @title = "Spot a Douche"
    #@photos = Photo.find(:all, :order=> 'created_at desc', :conditions => "status >= 5")
    @photos = Photo.paginate :page => params[:page], :order => 'created_at DESC', :conditions => "status >= 5", :per_page => 5
  end
  def about
    @title = "Spot a Douche - About Us"
  end
  def rights
    @title = "Spot a Douche - Submission Rights"
    if params[:facebox] == 'true'
      render :template => false
    end
  end
  def anony
    @title = "Spot a Douche - What is Anonymous Posting?"
    if params[:facebox] == 'true'
      render :template => false
    end
  end
  def dailydouche
    @title = "Spot a Douche - What is the Daily Douche?"
    if params[:facebox] == 'true'
      render :template => false
    end
  end
  def terms
    @title="Spot a Douche - Terms of Use"
  end
  def privacy
    @title="Spot a Douche - Privacy Policy"
  end 
end
