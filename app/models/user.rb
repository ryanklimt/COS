class User < ActiveRecord::Base
  has_many :referees
  has_many :players
  has_many :contests
  has_secure_password
  
  validates :username, :presence => true, length: { maximum: 20 }, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
end