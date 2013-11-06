class Referee < ActiveRecord::Base
  
  belongs_to :user
  has_many :matches, as: :manager
  
  def upload=(uploaded_io)
    if uploaded_io.nil?
      # problem--deal with later
    else
      time_no_spaces = Time.now.to_s.sub(/\s/, '_')
      file_location = Rails.root.join('code', 'referees', time_no_spaces + current_user.id.to_s)
      uploaded_file.read
    end
    self.file_location = 'the final location on the server'
  end
  
end