class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      cookies.signed[:user_id] = @user.id
      flash[:success] = "#{@user.username} logged in."
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_path
  end

end
