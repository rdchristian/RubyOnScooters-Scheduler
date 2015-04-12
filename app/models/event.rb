class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :end, :creator, :creator_name, :facility_ids, :resource_ids
  
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  accepts_nested_attributes_for :resources
  accepts_nested_attributes_for :facilities

  def creator_name
    return self.creator.name if self.creator
    'N/A'
  end

  def creator_name=(user_name)
    user = User.where(name: user_name).first
    if user then self.creator = user end
  end

  def facilities_list
    self.facilities.all.map(&:name).join(', ')
  end

  def resources_list
    self.resources.all.map(&:name).join(', ')
  end
end
