class Resource < ActiveRecord::Base
	attr_accessible :name, :description, :numberOf, :storage_location, :max_reserve_time
	
	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create

	def self.search(q)
		Resource.events.where("start_date = ? and (start <= ? or ending >= ?)",q[:start_date],q[:ending],q[:start])
	end
end
