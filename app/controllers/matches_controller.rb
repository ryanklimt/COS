class MatchesController < ApplicationController

  def index
    @contest = Contest.find(params[:contest_id])
    @matches=Match.all
  end
  
  def show
    @match=Match.find(params[:id])
  end
  
end