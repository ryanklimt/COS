class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(params[:user])
    if(@user.save)
      redirect_to @user
    else
      render 'new'
    end
  end
end
