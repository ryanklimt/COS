class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  validates :name, :presence => true
  validates :rules_url, :presence => true
  validates_numericality_of :players_per_game, :greater_than => 0 
  
  def upload=(uploaded_io)
    if uploaded_io.nil?
      #problem--deal with later
    else
      time_no_spaces = Time.now.to_s.sub(/\s/, '_')
      file_location = Rails.root.join('code', 'referees', Rails.env, time_no_spaces).to_s
      IO::copy_stream(uploaded_io, file_location)
      self.file_location = file_location
    end
  end
end