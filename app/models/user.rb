class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_many :events
	before_save {self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, :presence => true, on: :create
	validates :email, :presence => true, :uniqueness => true, format: { with: VALID_EMAIL_REGEX}, on: :create
	has_secure_password
	validates :password, length: { minimum: 8 }
end
