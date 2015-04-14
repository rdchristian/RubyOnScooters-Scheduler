class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :start_date, :duration,
                  :creator, :facility_ids, :resource_ids, :creator_name
  attr_accessor :start_date # virtual attribute
  # :end is set through duration
  
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  accepts_nested_attributes_for :resources
  accepts_nested_attributes_for :facilities

  def duration
    diff_in_min = ((self.end - self.start) / 60).round  # converting difference from seconds to minutes
    h, m = diff_in_min / 60, diff_in_min % 60
    "#{h}:#{m}".to_time
  end

  def duration=(d)
    d = d.to_time
    self.end = self.start.advance({:hours => d.hour, :minutes => d.min})
  end

  def creator_name
    self.creator.name if self.creator
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
