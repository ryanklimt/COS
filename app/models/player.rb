class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :matches, through: :player_matches
  has_many :player_matches
  validates :user,  presence: true
  validates :contest, presence: true
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :file_location, presence: true
  
  validate :check_file_location
  
  def upload=(uploaded_file)
    if uploaded_file.nil?
      #problem no file
    else
      time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
      salt = ""
      (9).times { salt += (65 + rand(26)).chr }
      file_location = Rails.root.join('code', 'players', Rails.env, Digest::SHA1.hexdigest(time_no_spaces + salt)).to_s
      IO::copy_stream(uploaded_file, file_location)
    end
    self.file_location = file_location
  end
  
  before_destroy :delete_file
  
  def delete_file
    File.delete(self.file_location)
  end
  
  def check_file_location
    if(self.file_location && !File.exists?(self.file_location))
      errors.add(:file_location, "Invalid file location")
    end
  end
  
end