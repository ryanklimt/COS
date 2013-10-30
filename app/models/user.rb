class User < ActiveRecord::Base
  has_many :referees
  has_many :players
  has_many :contests
  has_secure_password
  
  validates :username, :presence => true, length: { maximum: 20 }, uniqueness: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
                    
  #attr_accessor :username, :email
end