class RefereesController < ApplicationController
  
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
  
end