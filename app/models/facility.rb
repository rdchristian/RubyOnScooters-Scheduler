class Facility < ActiveRecord::Base
	attr_accessible :name, :description, :capacity, :priority, :min_capacity, :has_tv, :has_proj, :has_tables, :has_chairs, :has_sound

	has_and_belongs_to_many :events

	validates :name, :presence => true, :uniqueness => true, on: :create

end
