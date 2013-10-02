class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(acceptable_params)
    if @user.save then
      redirect_to @user
    else
      render 'new'
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
    if @user.update(acceptable_params) then
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def acceptable_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
