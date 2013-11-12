class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #cookies.signed[:user_id] = @user.id
      log_in(@user)
      flash[:success] = "#{@user.username} logged in"
      redirect_to @user  
    else
      flash.now[:danger] = "Invalid username/password!!!!"
      render 'new'
    end
  end
  
  def destroy
    cookies.delete :user_id
    flash[:info] = "Logged Out"
    redirect_to root_path
  end
  
end