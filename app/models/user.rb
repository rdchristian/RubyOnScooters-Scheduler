class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	attr_accessor :remember_token
	has_many :events
	before_save {self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, :presence => true, on: :create
	validates :email, :presence => true, :uniqueness => true, format: { with: VALID_EMAIL_REGEX}, on: :create
	has_secure_password
	validates :password, length: { minimum: 8 }


def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #Forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
