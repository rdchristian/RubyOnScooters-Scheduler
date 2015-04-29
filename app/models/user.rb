class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :phone, :home_group, :user_level, :activated
	attr_accessor :remember_token

  #user_level of 0 means normal user, 1 means staff and 2 means admin

	has_many :events
	before_save {self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A[0-9]{10}\z/
	validates :name, :presence => true
	validates :email, :presence => true, :uniqueness => true, format: { with: VALID_EMAIL_REGEX}
  validates :phone, format: {with: VALID_PHONE_REGEX}
	has_secure_password
  validates :password, length: { minimum: 8 }, :if => :password
  #password is not saved in db, only changes if there is a user input passowrd (so if user is being created or password is changing)


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

  def is_activated?
    return activated
  end

  def is_admin?
    return user_level == 2
  end

  def is_staff?
    return user_level == 1
  end

  def is_reg?
    return user_level == 0
  end

  def level_string
    if user_level == 0
      return 'Regular'
    elsif user_level == 1
      return 'Staff'
    else
      return 'Administrator'
    end
  end

end
