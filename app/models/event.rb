class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :start_date, :duration, :ending, :recurrence, :recur_until,
                  :creator, :facility_ids, :resource_ids, :resource_counts, :creator_name,
                  :approved, :checked_in, :attendees, :memo, :picture
  attr_accessor :start_date # virtual attribute
  # :ending is set through duration

  serialize :resource_counts, Hash # Number of each resource
  serialize :recurrence, Hash
  
  # Relationships
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  mount_uploader :picture, PictureUploader

  accepts_nested_attributes_for :resources
  accepts_nested_attributes_for :facilities

  # IceCube - Recurrence management
  include IceCube

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

  def recurrence_conflict?(start_t, end_t)
    recurrence.occurring_between?(start_t, end_t) #or 
    # to account for end time (recurrence only knows about the start time)
    # recurrence.occurring_between?(start_t - duration_seconds, end_t - duration_seconds)
  end

  def self.overlapping_events_to_a(start_t, end_t)
    q =  self.where("start <= ? and ending >= ?", end_t, start_t).to_a
    q += self.where.not(recurrence: nil).
              where("recur_until IS NOT NULL OR recur_until <= ?", start_t).
         select { |e| e.recurrence_conflict?(start_t, end_t) }
  end

  # Validations
  validates :title, :start, :creator, :presence => true
  validates :start, date: true
  validates :recur_until, date: { after: :ending, allow_blank: true, message: 'must be after the starting date.' }
  validate  :valid_resource_counts, :resources_available, :facility_available, :picture_size

  def valid_resource_counts
    # Integerize { '3' => '5' } --> { 3 => 5 } 
    self.resource_counts = Hash[*resource_counts.to_a.flatten.map(&:to_i)]

    # Every resource has to have a count
    errors.add(:resource_counts, ': resource does not have a count') if
      not resources.collect(&:id).all? { |id| resource_counts.has_key?(id) }
      
    # Every count has to belong to a resource (silently fix it)
    logger.debug('Attempting to clean resource_counts hash') if
      self.resource_counts.reject! { |key, value| not resources.collect(&:id).include?(key) }
  end

  def num_of_resources_reserved_at_my_time(resource_id)
    Resource.find(resource_id).events.where.not(id: id).      # Except yourself
             overlapping_events_to_a(start, ending).
             map{ |e| e.resource_counts[resource_id] }.       # Collect the number of this resource reserved
             sum + resource_counts[resource_id]               # Now count yourself in
  end

  def resources_available
    resources.each do |res|
      errors.add(:resources, ': All "' + res.name + '" are taken') if 
        num_of_resources_reserved_at_my_time(res.id) > res.numberOf

      return unless res.max_reserve_time
      maxt = res.max_reserve_time
      max_end_time = start.advance({:hours => maxt.hour, :minutes => maxt.min})
      errors.add(:resources, ': Cannot reserve "' + res.name + '" for this long') if 
        ending > max_end_time
    end
  end

  def num_of_facilities_reserved_at_my_time(facility_id)
    Facility.find(facility_id).events.where.not(id: id).   # Except yourself
             overlapping_events_to_a(start, ending).
             count
  end

  def facility_available
    facilities.each do |fac|
      errors.add(:facilities, ': "' + fac.name + '" is taken') if 
        num_of_facilities_reserved_at_my_time(fac.id) > 0

      return unless fac.max_reserve_time
      maxt = fac.max_reserve_time
      max_end_time = start.advance({:hours => maxt.hour, :minutes => maxt.min})
      errors.add(:facilities, ': Cannot reserve "' + fac.name + '" for this long') if 
        ending > max_end_time
    end
  end

  # Called from the controller
  def calculate_recurrence_exceptions
    exceptions = []
    same_time_events = 
      Event.where("start >= ?", recurrence.first.to_time). # Every event in the future of this event
      where(recurrence: nil).collect { |e|              # Collect conflicts with non-recurring events
        e if recurrence_conflict?(e.start, e.ending)
      }.compact

    facilities.each do |fac|
      exceptions += same_time_events.
        collect{ |e| recurrence.previous_occurrence(e.ending) if 
          e.facilities.exists?(fac.id)
        }.compact
    end

    resources.each do |res|
      exceptions += same_time_events.
        collect{ |e| recurrence.previous_occurrence(e.ending) if
          same_time_events.map{ |e| e.resource_counts[res.id] }.  # Collect the number of this resource reserved
          sum + resource_counts[res.id] > res.numberOf
        }.compact
    end
    return exceptions.uniq!{ |x| x.hash }
  end


  # Methods that will be used to determine if event requires approval
  def capacity_check
    facilities.each do |fac|
      if (fac.capacity and fac.capacity < attendees) or (fac.min_capacity and fac.min_capacity > attendees)
        return false
      end
    end
    return true
  end

  def facility_priority_check
    facilities.each do |fac|
      if fac.priority
        return false
      end
    end
    return true
  end 

  def recurring_check
    return !recurrence.present?  
  end

  def schedule_time_check
    if creator.is_reg? && ((Date.parse(start_date) - Date.today) <= Rails.application.config.REGULAR_SCHEDULE_DAYS || Rails.application.config.REGULAR_SCHEDULE_DAYS == -1)
      return true
    elsif (creator.is_staff?) && ((Date.parse(start_date) - Date.today) <= Rails.application.config.STAFF_SCHEDULE_DAYS || Rails.application.config.STAFF_SCHEDULE_DAYS == -1)
      return true
    elsif (creator.is_admin?) && ((Date.parse(start_date) - Date.today) <= Rails.application.config.ADMIN_SCHEDULE_DAYS || Rails.application.config.ADMIN_SCHEDULE_DAYS == -1)
      return true
    else
      return false
    end
  end

  # Getters, setters, helpers, and virtual attributes
  def duration
    return nil unless ending or start
    diff_in_min = ((ending - start) / 60).round  # converting difference from seconds to minutes
    h, m = diff_in_min / 60, diff_in_min % 60
    "#{h}:#{m}".to_time
  end

  def duration_seconds
    return nil unless ending or start
    (ending - start).seconds
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

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB!")
      end
    end
end
