class Match < ActiveRecord::Base
  
  belongs_to :contest
  belongs_to :referee
  belongs_to :manager, polymorphic: true
  has_many :players, through: :player_matches
  has_many :player_matches
  
  validates :manager, presence: true
  validates :status, presence: true
  validates_date :completion, :on_or_before => lambda { Time.now.change(:usec =>0) }, :if => :is_completed
  validates_datetime :earliest_start, :if => :is_started
  
  validate :player_count
  
  def is_completed
    if self.status != "Completed"
      return nil
    else
      return true
    end
  end
  
  def is_started
    if self.status == "Completed" || self.status == "Started"
      return nil
    else
      return true
    end
  end
  
  def player_count
    if self.players && self.manager
      if self.players.count != self.manager.referee.players_per_game
        errors.add(:player_matches,"Wrong number of players!")
      end
    end
  end
  
end