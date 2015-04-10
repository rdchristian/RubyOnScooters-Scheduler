class Resource < ActiveRecord::Base
	attr_accessible :name, :description, :numberOf, :storage_location, :max_reserve_time
	has_and_belongs_to_many :events
	validates :name, :presence => true, :uniqueness => true, on: :create

	def generate_hours
    	Array.new(24.hours / 15.minutes) do |i| 
        (Time.now.midnight + (i*30.minutes)).strftime("%k:%M")
    end
  end
end
