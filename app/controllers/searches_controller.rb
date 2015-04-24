class SearchesController < ApplicationController
	def new
		@search = Search.new
	end

	def create
		@search = Search.create!(params[:search])
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
	end

	helper_method :format_fields
	def format_fields
		params[:duration] = @search.duration.strftime("%I:%M") if @search.duration
		params[:start_time] = @search.start.strftime("%I:%M %p") if @search.start
		params[:start_date] = @search.start.strftime("%B %e, %Y") if @search.start
		params[:ending] = @search.ending.strftime("%B %e, %Y, %I:%M %p") if @search.ending
	end
end
