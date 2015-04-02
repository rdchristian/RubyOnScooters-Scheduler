class Resource < ActiveRecord::Base
	attr_accessible :name, :description, :numberOf
	validates :name, :presence => true, :uniqueness => true, on: :create
end
