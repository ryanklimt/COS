module SessionsHelper

  def current_user
    @current_user ||= User.find(cookie[:user_id]) if cookie[:user_id]
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def logged_in?
    !current_user.nil?
  end

end