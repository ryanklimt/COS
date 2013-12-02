class Match < ActiveRecord::Base
  belongs_to :contest
  belongs_to :referee
  belongs_to :manager, polymorphic: true
  has_many :players, through: :player_matches
  has_many :player_matches
  
  validates :manager, presence: true
  validates :status, presence: true
  #validates :completion, presence: true, :timeliness => {:on_or_before => :now, :type => :date}
  validates :earliest_start, presence: true
  
end