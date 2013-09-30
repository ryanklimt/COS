class UsersController < ApplicationController
  def index
    @users = User.all
  end  
  def new
    @user = User.new
  end
  def create
    permitted_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(permitted_params)
    if(@user.save)
      redirect_to @user
    else
      render 'show'
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if(@user.update_attributes(:username => params[:username], :email => params[:email]))
      redirect_to @user
    else
      render 'edit'
    end
  end
end
