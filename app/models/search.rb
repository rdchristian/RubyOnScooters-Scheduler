class Search < ActiveRecord::Base
	attr_accessible :start_date, :start, :ending, :duration

	#validates :start, date: true

	def resources_results
		@resources_results ||= find_resources
	end

	def facilities_results
		@facilities_results ||= find_facilities
	end

	def duration
		return nil unless ending or start
		diff_in_min = ((ending - start) / 60).round
		h, m = diff_in_min / 60, diff_in_min % 60
		"#{h}:#{m}".to_time
	end

	def duration=(d)
		d = d.to_time
		self.ending = start.advance({:hours => d.hour, :minutes => d.min})
	end

	private
	def find_resources
		Resource.search({:start_date => start_date, :start => start, :ending => ending})
	end

	def find_facilities
		Facility.search({:start_date => start_date, :start => start, :ending => ending})
	end
end
