require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :session_token, :username, :password

  has_many :memberships
  has_many :friend_circles, :through => :memberships
  has_many :owned_friend_circles,
           :foreign_key => :owner_id
  has_many :friend_posts, :through => :friend_circles, :source => :posts

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(user_params)
    user = User.find_by_username(user_params[:username])
    user && user.password == user_params[:password] ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end

  def is_member?(fc)
    false
  end
end
