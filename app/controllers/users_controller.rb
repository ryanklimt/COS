class UsersController < ApplicationController

  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_admin, only: [:destroy]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(acceptable_params)
    if @user.save then
      flash[:success] = "Welcome to the site: #{@user.username}"
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
      flash[:success] = "Updates made to the user: #{@user.username}"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User successfully deleted"
    redirect_to users_path
  end

  private

    def acceptable_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def ensure_user_logged_in
      redirect_to login_path unless logged_in?
    end
    
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
    def ensure_admin
      flash[:danger] = "Unable to delete user [not admin]"
      redirect_to root_path unless current_user.admin?
    end

end