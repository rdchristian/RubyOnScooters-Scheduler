class Search < ActiveRecord::Base
	attr_accessible :start_date, :start, :duration, :ending
	attr_accessor :start_date # virtual attribute

	# Relationships
	#belongs_to :searchable, polymorphic :true
end