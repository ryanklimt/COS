class Referee < ActiveRecord::Base
  belongs_to :user
  
  has_many :contests
  has_many :matches, as: :manager
  
  validates :name, presence: true, uniqueness: true
  validates :rules_url, presence: true, format: { with: /https?:\/\/[\S]+/i }
  validates :players_per_game, presence: true, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10, only_integer: true}
  
  include Uploadable
  
end