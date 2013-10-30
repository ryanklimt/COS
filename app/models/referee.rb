class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :matches, as: :manager
  has_many :contests
end