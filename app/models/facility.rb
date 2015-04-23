class Facility < ActiveRecord::Base
	attr_accessible :name, :description, :capacity, :priority, :min_capacity, :has_tv, :has_proj, :has_tables, :storage_location, :max_reserve_time

	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create
end
