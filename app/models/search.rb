#!/usr/bin/ruby
# @Author: Synix
# @Date:   2015-05-04 04:01:32
# @Last Modified by:   Synix
# @Last Modified time: 2015-05-04 17:04:37

class Search


	def self.events(params)
		query   = Event
		if params[:start] and params[:end]
			query_a = query.overlapping_events_to_a(params[:start], params[:end])
		else
			query_a = query.all
		end
		# For now, multiple resource conditions are OR'ed, and facilities and resources are AND'ed
		# E.g. Look for Events that have (chairs OR pencils) AND are in a classroom
		# & is Array intersection (common elements)
		query_a.select! { |event| (event.resources.ids & params[:resources]).present? } if params[:resources]
		query_a.select! { |event| (event.facilities.ids & params[:facilities]).present? } if params[:facilities]

		return query_a
	end

	# This function returns exceptions to the given search criteria, because by default you can schedule
	# a resource at any time UNLESS there's a conflict.
	def self.resources(params)
		query   = Event
		# Find events associated with a resource name
		resource_ids = []
		if params[:name]
			query   = query.joins(:resources).where("lower(resources.name) LIKE ?", "%#{params[:name].downcase}%")
			resource_ids = query.select('resources.id as id').uniq.ids
		end
		# that cross the given time frame
		if params[:start] and params[:end]
			query_a = query.overlapping_events_to_a(params[:start], params[:end])
		else
			query_a = query.all
		end

		# See if they leave any resources for us to take
		exceptions = []
		query_a.each do |event|
			exceptions << event if 
				(resource_ids & event.resources.ids).any? do |res_id|
					event.num_of_resources_reserved_at_my_time(res_id) + params[:numberOf] > Resource.find(res_id).numberOf
				end
		end
		return exceptions
	end

	def self.facilities(params)
	end

end