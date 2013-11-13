class ContestsController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_contest_creator, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  
  def new
    @contest = current_user.contests.build
  end 
  
  def create
    @contest = current_user.contests.build(acceptable_params)
    if @contest.save then
      flash[:success] = "Contest #{@contest.name} created!"
      redirect_to @contest     
    else
      render 'new'
    end
  end
  
  def index
    @contests = Contest.all
  end
  
  def show
    @contest = Contest.find(params[:id])
  end
  
  def update
    if @contest.update_attributes(acceptable_params)
      flash[:success] = "Referee #{@contest.name} updated successfully!"
      redirect_to @contest
    else
      render 'edit'
    end
  end
  
  def edit
  end
  
  def destroy
    @contest = Contest.find(params[:id])
    if current_user?(@contest.user) #|| current_user.admin?
      @contest.destroy
      flash[:success] = "Referee destroyed."
      redirect_to contests_path
    else
      flash[:danger] = "Can't delete contest."
      redirect_to root_path
    end 
  end
  
  private
    def acceptable_params
      params.require(:contest).permit(:referee_id, :name, :contest_type, :description, :start, :deadline)
    end
    
   def ensure_correct_user
       @contest = Contest.find(params[:id])
       redirect_to login_path, flash: { :danger => "Must be Logged in as correct user!" } unless current_user?(@contest.user)
    end
       
    def ensure_user_logged_in
     redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in? 
    end
    
    def ensure_contest_creator 
      redirect_to root_path, flash: { :danger => "You are not a contest creator!" } unless current_user.contest_creator?
    end
    
end