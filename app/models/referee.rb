class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
end