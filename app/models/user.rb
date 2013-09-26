class User < ActiveRecord::Base
  has_secure_password
  
  validates :username, :presence => true
  validates_length_of :username, :maximum => 25
  validates_uniqueness_of :username
  
  validates :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
