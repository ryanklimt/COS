class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:create, :edit, :update]
  before_action :ensure_admin_user, only: [:destroy]
  
    
  def new
    @referee = current_user.referees.build
  end 
  
  def create
    @referee = current_user.referees.build(acceptable_params)
    if @referee.save then
      flash[:success] = "Referee #{@referee.name} created!"
      redirect_to @referee     
    else
      render 'new'
    end
  end
  
  def index
    @referees = Referee.all
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
  
  def update
    @referee = Referee.find(params[:id])
    if @referee.update_attributes(acceptable_params)
      flash[:success] = "Referee #{@referee.name} updated successfully!"
      redirect_to @referee
    else
      render 'edit'
    end
  end
  
  def edit
    @referee = Referee.find(params[:id])
  end
  
  def destroy
  end
  
  private
    def acceptable_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
    
    def ensure_admin_user
      redirect_to users_path unless current_user.admin?
    end 
   
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable, please log in!" } unless logged_in? 
    end   
    
end