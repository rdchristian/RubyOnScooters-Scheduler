class Facility < ActiveRecord::Base
  attr_accessible :name, :description
  validates :name, :presence => true, :uniqueness => true, on: :create
end