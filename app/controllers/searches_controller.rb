require 'json'

class SearchesController < ApplicationController

	def new
		@search = Search.new
		#@search = @scope.new
	end

	def create
		@search = Search.create!(search_params)
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
	end

	private
	helper_method :format_fields
	def format_fields
		params[:start_time] = @search.start.strftime("%I:%M %p") if @search.start
		params[:start_date] = @search.start.strftime("%B %e, %Y") if @search.start
		params[:ending_time] = @search.ending.strftime("%I:%M %p") if @search.ending
		params[:ending_date] = @search.ending.strftime("%B %e, %Y") if @search.ending
	end

	def search_params
		form = params[:search]
		if form[:start].is_a? String
			s_date, s_time = form[:start_date], form[:start]
			form[:start] = Time.zone.parse(s_date + ' ' + s_time).to_datetime
			e_date, e_time = form[:ending_date], form[:ending]
			form[:ending] = Time.zone.parse(e_date + ' ' + e_time).to_datetime
		end
		params.require(:search).permit(:start_date, :start, :ending_date, :ending)
	end
end
