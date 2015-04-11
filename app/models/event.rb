class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :end
  belongs_to :creator, :class_name => :User,:foreign_key => "user_id"
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities
end
