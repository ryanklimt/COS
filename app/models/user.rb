class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :email, :username
  def email
  end
  def email=(new_email)
  end
end
