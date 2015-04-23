class Search < ActiveRecord::Base
	attr_accessible :start_date, :start, :ending

	#has_many :resources
	#has_many :facilities

	def resources_results
		@resources_results ||= find_resources
	end

	def facilities_results
		@facilities_results ||= find_facilities
	end

	private
	def find_resources
		Resource.search({:start_date => start_date, :start => start, :ending => ending})
	end

	def find_facilities
		Facility.search({:start_date => start_date, :start => start, :ending => ending})
	end
end
