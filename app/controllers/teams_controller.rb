class TeamsController < ApplicationController
  def show
    @team=Team.find(params[:id])
  end
  
  def index
    @teams = current_user.teams
    @team = current_user.teams.build
  end
  
  def create
    @team = current_user.teams.build(params[:team])
    if @team.save
      flash[:success] = "Team created!"
      redirect_to user_path(@team.user_id)
    else
      redirect_to user_path(current_user)
    end
  end
  
  def destroy
    @team=Team.find(params[:id])
    @team.destroy
    redirect_to user_path(current_user)
  end
end
