class Contest < ActiveRecord::Base
  has_many :players
  has_many :matches, as: :manager
end