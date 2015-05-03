class SearchController < ApplicationController
  before_filter :authenticate_user!

  def show
    @what = 'say what ' * 2
    search if params[:results].present?
  end

  def search
    @results = [] << params[:results]

    if pjax_request?
      render layout: false, action: 'results', locals: { results: @results }
    end
  end

end
