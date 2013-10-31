class User < ActiveRecord::Base
  belongs_to :referees
  belongs_to :players
  belongs_to :contests
  has_secure_password
  
  validates :username, :presence => true, length: { maximum: 20 }, uniqueness: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
end