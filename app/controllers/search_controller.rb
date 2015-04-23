class SearchController < ApplicationController
  def index
  	@facilities_results = Facilities.search(params[:q])
  	@resources_results = Resources.search(params[:q])
  end

  def search
  	@facilities_results = Facilities.search(params[:q])
  	@resources_results = Resources.search(params[:q])
  end

  def results
  end
end
