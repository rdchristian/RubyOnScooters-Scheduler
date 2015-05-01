require 'json'

class ObjSearchesController < ApplicationController

	def new
		@obj_search = Obj_search.new
	end

	def create
		@obj_search = Obj_search.create!(obj_search_params)
		redirect_to @obj_search
	end

	def show
		@obj_search = Obj_search.find(params[:id])
	end

	private
	helper_method :format_fields
	def format_fields
		
	end

	def obj_search_params
		form = params[:obj_search]
		form[:date] = params[:date]
		form[:facility_ids] = params[:facility_ids]
		form[:resource_ids] = params[:resource_ids]
	end
end