class LeaguesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @league=Team.all.sort! { |a,b| b.points<=>a.points }
  end

  def show
  end

  def new
    @league=League.new
  end
  
  def create
    @league=League.new(params[:league])
    if @league.save
      flash[:alert] = "League Successfully created"
      redirect_to league_path(@league)
    else
      flash[:alert] = "League already exists"
      redirect_to new_league_path
    end
  end
end
