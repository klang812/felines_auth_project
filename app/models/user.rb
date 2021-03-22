class User < ApplicationRecord
  attr_accessor :password
  attr_accessor :admin
  validates_confirmation_of :password
  # validates :password, format: PASSWORD_REQUIREMENTS
  validates :email, :presence => true, :uniqueness => true
  before_save :encrypt_password

  # if current_user && current_user.admin
  #   user = User.find_by "email = ?", email
  #   user
  # end

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by "email = ?", email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  # PASSWORD_REQUIREMENTS = /\A
  #   (?=.{8,})
  #   (?= .*\d)
  #   (?=.*[a-z])
  #   (?=.*[A-Z])
  #   (?=.*[[:^alnum:]])
  #   /x


end