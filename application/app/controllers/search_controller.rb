class SearchController < ApplicationController
  def index
    @title = "Spot a Douche - Search"
    unless params[:query].nil?
      q = "#{params[:query]} +status:5"
      @total = Photo.total_hits(q)
      unless params[:pp] then pp = 10 else pp = params[:pp] end
      @results = Photo.paginate(q, {:finder => "find_with_ferret", :total_entries => @total}.merge({:page => params[:page], :per_page => pp}))
      @paginate = @results
    end
    if request.post?
      redirect_to :action => 'index', :query => params[:search][:q]
    end
  end 
  
end
