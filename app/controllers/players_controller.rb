class PlayersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update]
  #before_action :ensure_contest_creator, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  # /contests/:contest_id/players/new
  def new
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build
  end 
  
  # /contests/:contest_id/players
  def create
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build(acceptable_params)
    if @player.save then
      flash[:success] = "Referee #{@player.name} created!"
      redirect_to @player     
    else
      render 'new'
    end
  end
  
  def index
    @players = Player.all
  end
  
  def show
    @player = Player.find(params[:id])
  end
  
  def update
    if @player.update_attributes(acceptable_params)
      flash[:success] = "Referee #{@player.name} updated successfully!"
      redirect_to @player
    else
      render 'edit'
    end
  end
  
  def edit
  end
  
  def destroy
    @player = Player.find(params[:id])
    if current_user?(@player.user) #|| current_user.admin?
      @player.destroy
      flash[:success] = "Player destroyed."
      redirect_to contest_players_path(params[:id])
    else
      flash[:danger] = "Can't delete player."
      redirect_to root_path
    end 
  end
  
  private
    def acceptable_params
      params.require(:player).permit(:contest_id, :name, :description, :upload)
    end
    
    def ensure_correct_user
      @player = Referee.find(params[:id])
      redirect_to root_path, flash: { :danger => "Must be Logged in as correct user!" } unless current_user?(@player.user)
    end
   
    def ensure_user_logged_in
     redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in? 
    end
    
    def ensure_contest_creator
      redirect_to root_path, flash: { :danger => "You are not a contest creator!" } unless current_user.contest_creator?
    end 

end