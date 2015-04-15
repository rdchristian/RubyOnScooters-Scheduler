class Facility < ActiveRecord::Base
	attr_accessible :name, :description, :capacity, :storage_location, :max_reserve_time, :picture

	has_and_belongs_to_many :events

	mount_uploader :picture, PictureUploader

	validates :name, :presence => true, :uniqueness => true, on: :create
	validate :picture_size

	private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB!")
      end
    end
end
