class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches, as: :manager
  validates :referee, presence: true
  validates :user, presence: true
  
  validates :name, presence: true, uniqueness: true
  validates :contest_type, presence: true
  validates :start, presence: true 
  validates :deadline, presence: true
  validates :description, presence: true
  
  validates_datetime :deadline, :on_or_after => lambda {Time.now.change(:usec => 0)}
  validates_datetime :start, :on_or_after => lambda {:deadline}
  
end