class User < ActiveRecord::Base
  has_secure_password
  def email
  end
  def email=(new_email)
  end
end
