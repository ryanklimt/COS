class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
  validates :name, presence: true
  VALID_URL_REGEX = /https?:\/\/[\S]+/i 
  validates :rules_url, presence: true, format: { with: VALID_URL_REGEX }
  validates :players_per_game, presence: true, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10, only_integer: true}
  validates :file_location, presence: true 
  
  def upload=(uploaded_file)
    if uploaded_file.nil?
      #problem no file
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
      salt = ""
      (9).times { salt += (65 + rand(26)).chr }
      file_location = Rails.root.join('code', 'referees', Rails.env, Digest::SHA1.hexdigest(time_no_spaces + salt)).to_s
      IO::copy_stream(uploaded_file, file_location)
    end
    self.file_location = file_location
  end
  
  before_destroy :delete_file
  
  def delete_file
    File.delete(self.file_location)
  end
end