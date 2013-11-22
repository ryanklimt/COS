class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  
  has_many :matches, through: :player_matches
  has_many :player_matches
  
  validates :user,  presence: true
  validates :contest, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
  include Uploadable
  
end