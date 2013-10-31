class PlayerMatch < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  validates :match, presence: true
  validates :player, presence: true
end