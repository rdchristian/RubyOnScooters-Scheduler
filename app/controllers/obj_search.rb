class Obj_search < ActiveRecord::Base
	attr_accessible :date, :facility_ids, :resource_ids, :resource_counts

	serialize :resource_counts
	has_many :resources
	has_many :facilities

	def events_results
		facility_ids.each do |fid|
			@event_results ||= Facility.find(fid).events.where("start_date == ?", date)
		end
		resource_ids.each do |rid|
			@event_results ||= Resource.find(rid).events.where("start_date == ?", date)
		end
		return @event_results
	end
end