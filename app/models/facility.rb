class Facility < ActiveRecord::Base
	attr_accessible :name, :description, :capacity, :priority, :min_capacity, :has_tv, :has_proj, :has_tables, :has_chairs, :has_sound

	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create

	def self.search(q)
		Facility.all do |fac|
			fac.events.where("start_date = ? and ((start <= ? and ending <= ?) or (start >= ? and ending >= ?))",q[:start_date],q[:ending],q[:ending],q[:start],q[:start])
		end
	end
end
