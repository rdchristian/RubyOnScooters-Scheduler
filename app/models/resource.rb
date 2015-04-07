class Resource < ActiveRecord::Base
	attr_accessible :name, :description, :numberOf
	has_and_belongs_to_many :events
	validates :name, :presence => true, :uniqueness => true, on: :create
end
