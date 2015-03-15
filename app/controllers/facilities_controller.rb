class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def show
    id = params[:id]
    @facility = Facility.find(id)
  end
end
