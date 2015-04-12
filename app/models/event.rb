class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :end, :creator, :creator_name
  
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  def creator_name
    return self.creator.name if self.creator
    'N/A'
  end

  def creator_name=(user_name)
    user = User.where(name: user_name).first
    if user then self.creator = user end
  end
end
