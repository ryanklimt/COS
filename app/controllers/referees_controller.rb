class RefereesController < ApplicationController
  
  #before_action :ensure_user_logged_in
  
  def new
    @referee = current_user.referees.build
  end
  
  def create
    @referee = current_user.referees.build(acceptable_params)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    
    def acceptable_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
  
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Unable" } unless logged_in? 
    end
  
end