class Search < ActiveRecord::Base
	attr_accessible :start_date, :start, :ending_date, :ending

	serialize :resource_counts, Hash

	#validates :start, date: true

	def resources_results
		#@resources_results ||= find_resources
		@resources_results = Resource.search({:start => start, :ending => ending})
	end

	def facilities_results
		#@facilities_results ||= find_facilities
		@facilities_results = Facility.search({:start => start, :ending => ending})
	end

	private
	def find_resources
		Resource.search({:start => start, :ending => ending})
	end

	def find_facilities
		Facility.search({:start => start, :ending => ending})
	end
end
