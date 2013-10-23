class UsersController < ApplicationController
  
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_admin_user, only: [:destroy]
  before_action :ensure_not_logged_in, only: [:new, :create]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save then
      log_in(@user)
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
    if @user.update_attributes(user_params)
      flash[:success] = "User: #{@user.username} updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end
    
  def destroy
    @user = User.find(params[:id])
    if !current_user?(@user)
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_path
    else
      flash[:danger] = "Can't delete yourself"
      redirect_to root_path
    end 
  end 
    
  private
    
    def ensure_admin_user
      redirect_to users_path unless current_user.admin?
    end 
   
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable [not logged in]" } unless logged_in? 
    end
    
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to root_path, flash: { :danger => "Unable [not correct user]" } unless current_user?(@user)
    end
    
    def ensure_not_logged_in
      redirect_to root_path, flash: { :warning => "Unable [not admin]" } unless !logged_in?
    end 
    
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
end