class Facility < ActiveRecord::Base
	attr_accessible :name, :description, :capacity, :storage_location, :max_reserve_time

	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create

	def self.search(q)
		Facility.events.where("start_date = ? and (start <= ? or ending >= ?)",q[:start_date],q[:ending],q[:start])
	end
end
