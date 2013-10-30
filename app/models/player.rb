class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :matches, through: :player_matches
end