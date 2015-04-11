class User < ActiveRecord::Base
	attr_accessor :name
	has_many :events
end
