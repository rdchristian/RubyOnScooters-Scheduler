class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start, :start_date, :duration, :ending,
                  :creator, :facility_ids, :resource_ids, :creator_name
  attr_accessor :start_date # virtual attribute
  # :ending is set through duration
  
  belongs_to :creator, :class_name => :User, :foreign_key => "user_id"  
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :facilities

  accepts_nested_attributes_for :resources
  accepts_nested_attributes_for :facilities

  #Validations
  validates :title, :start, :ending, :creator, :presence => true
  validates :ending, date: { after: :start, message: 'must be after start date' }
  validate :resources_available, :facility_available

  def resources_available
    resources.each do |res|
      errors.add(:resources, ': All "' + res.name + '" are taken') if 
        Resource.find(res.id).events.
                 where("start <= ? and ending >= ?", ending, start).
                 count >= res.numberOf

      maxt = res.max_reserve_time
      max_end_time = start.advance({:hours => maxt.hour, :minutes => maxt.min})
      errors.add(:resources, ': Cannot reserve ' + res.name + ' for this long') if 
        ending > max_end_time
    end
  end

  def facility_available

  end

  # Helpers and virtual attributes
  def duration
    diff_in_min = ((ending - start) / 60).round  # converting difference from seconds to minutes
    h, m = diff_in_min / 60, diff_in_min % 60
    "#{h}:#{m}".to_time
  end

  def duration=(d)
    d = d.to_time
    ending = start.advance({:hours => d.hour, :minutes => d.min})
  end

  def creator_name
    creator.name if creator
  end

  def creator_name=(user_name)
    user = User.where(name: user_name).first
    if user then creator = user end
  end

  def facilities_list
    facilities.all.map(&:name).join(', ')
  end

  def resources_list
    resources.all.map(&:name).join(', ')
  end
end
