class Search < ActiveRecord::Base
	attr_accessible :start_date, :start, :ending_date, :ending

	#validates :start, date: true

	def resources_results
		#@resources_results ||= find_resources
		@resources_results = Resource.all
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
