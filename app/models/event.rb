class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :start_date, :duration, :ending, :recurrence,
                  :creator, :facility_ids, :resource_ids, :creator_name, :approved, :checked_in, :attendees
  attr_accessor :start_date # virtual attribute
  # :ending is set through duration

  #Relationships
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  accepts_nested_attributes_for :resources
  accepts_nested_attributes_for :facilities

  #IceCube - Recurrence management
  include IceCube
  serialize :recurrence, Hash

  def recurrence=(recurr)
    recurr = recurr.blank? ? {} : recurr.to_hash
    write_attribute(:recurrence, recurr)
  end

  def recurrence
    recurr = read_attribute(:recurrence)
    Schedule.from_hash(recurr) if recurr.present?
  end

  def self.recurrence_options
    %w( Days Weeks Months )
  end

  def self.get_recurrence_rule(option)
    { 
      'Days'   => Rule.method(:daily),
      'Weeks'  => Rule.method(:weekly),
      'Months' => Rule.method(:monthly),
    }[option]
  end

  #Validations
  validates :title, :start, :creator, :presence => true
  validates :start, date: true
  validate :resources_available, :facility_available

  def resources_available
    resources.each do |res|
      errors.add(:resources, ': All "' + res.name + '" are taken') if 
        Resource.find(res.id).events.
                 where("start <= ? and ending >= ? and id != ?", ending, start, id).  # Search overlapping timeframes
                 count >= res.numberOf

      return unless res.max_reserve_time
      maxt = res.max_reserve_time
      max_end_time = start.advance({:hours => maxt.hour, :minutes => maxt.min})
      errors.add(:resources, ': Cannot reserve "' + res.name + '" for this long') if 
        ending > max_end_time
    end
  end

  def facility_available
    facilities.each do |fac|
      errors.add(:facilities, ': All "' + fac.name + '" are taken') if 
        Facility.find(fac.id).events.
                 where("start <= ? and ending >= ? and id != ?", ending, start, id).  # Search overlapping timeframes
                 count > 0

      return unless fac.max_reserve_time
      maxt = fac.max_reserve_time
      max_end_time = start.advance({:hours => maxt.hour, :minutes => maxt.min})
      errors.add(:facilities, ': Cannot reserve "' + fac.name + '" for this long') if 
        ending > max_end_time
    end
  end

  #methods that will be used to determine if event requires approval
  def capacity_check
    facilities.each do |fac|
      if fac.capacity < :attendees || fac.min_capacity > :attendees
        return false
      end
    end
    return true
  end

  def facility_priority_check
    facilities.each do |fac|
      if !fac.priority
        return false
      end
    end
    return true
  end 

  # Getters, setters, helpers, and virtual attributes
  def duration
    return nil unless ending or start
    diff_in_min = ((ending - start) / 60).round  # converting difference from seconds to minutes
    h, m = diff_in_min / 60, diff_in_min % 60
    "#{h}:#{m}".to_time
  end

  def duration=(d)
    d = d.to_time
    self.ending = start.advance({:hours => d.hour, :minutes => d.min})
  end

  def creator_name
    creator.name if creator
  end

  def creator_name=(user_name)
    user = User.where(name: user_name).first
    if user then self.creator = user end
  end

  def facilities_list
    facilities.all.map(&:name).join(', ')
  end

  def resources_list
    resources.all.map(&:name).join(', ')
  end

  def is_approved?
    return approved
  end

  def resources_checked_in?
    return checked_in
  end

end
