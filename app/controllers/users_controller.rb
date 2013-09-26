class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    permitted_params = params.require(:user).permit(:username, :email, :password, :password_confirmation,)
    @user = User.new(permitted_params)
    if(@user.save)
      redirect_to @user
    else
      render 'new'
    end
  end
end
