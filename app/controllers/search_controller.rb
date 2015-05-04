class SearchController < ApplicationController
  before_filter :authenticate_user!

  def show
    redirect_to search_events_path # default search
  end

  def search_events
    @results = Resource.all
    render_response
  end

  def search_facilities
    render_response
  end

  def search_resources
    render_response
  end

private

  def render_response
    if params[:yo]
      render action: 'results', layout: false, locals: { results: @results }
      return
    end
    if pjax_request?
      render layout: false
    elsif params[:commit] == 'Search'
      render action: 'results', layout: false, locals: { results: @results }
    else
      respond_to do |format|
        format.html { render 'show' }
      end
    end
  end

end
