class SearchController < ApplicationController
  before_filter :authenticate_user!

  def show
    redirect_to search_events_path # default search
  end

  def search_events
    search = {}
    search[:start], search[:end] = params[:date_range].split('-').map!{ |x| Time.zone.parse(x) } if params[:date_range].present?
    search[:facilities] = params[:facilities].map!(&:to_i) if params[:facilities].present?
    search[:resources] = params[:resources].map!(&:to_i) if params[:resources].present?

    @results = Search.events(search) if params[:commit]
    render_response
  end

  def search_facilities
    search = {}
    search[:start], search[:end] = params[:date_range].split('-').map!{ |x| Time.zone.parse(x) } if params[:date_range].present?
    search[:name] = params[:name] if params[:name].present?
    search[:capacity] = params[:capacity].to_i if params[:capacity].present?

    @results = Search.facilities(search) if params[:commit]
    render_response
  end

  def search_resources
    search = {}
    search[:start], search[:end] = params[:date_range].split('-').map!{ |x| Time.zone.parse(x) } if params[:date_range].present?
    search[:name] = params[:name] if params[:name].present?
    # search[:storage] = params[:storage] if params[:storage].present?
    # search[:reserve_time] = params[:reserve_time].to_time if params[:reserve_time].present?
    params[:numberOf] = 1 if params[:numberOf].blank?
    search[:numberOf] = params[:numberOf].to_i

    @results = Search.resources(search) if params[:commit]
    render_response
  end

private

  def render_response
    # if params[:commit] == 'Search'
    #   render partial: 'results', locals: { results: @results }
    # else
    #   respond_to do |format|
    #     format.html { render 'show' }
    #   end
    # end
    respond_to do |format|
      format.html { render 'show' }
    end
  end

end
