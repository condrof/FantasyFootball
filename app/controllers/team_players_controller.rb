class TeamPlayersController < ApplicationController
    load_and_authorize_resource
  
  def create
    @team = Team.find(params[:team_player][:team_id])
    @relationship = @team.team_players.build(params[:team_player])
    if @relationship.save
      flash[:alert] = "Player added to team!"
      redirect_to edit_team_path(@team)
    else
      redirect_to users_path
    end
  end
    
  def destroy
    @team=@team_player.team
    @team_player.destroy
    flash[:alert] = "Player deleted from team!"
    redirect_to edit_team_path(@team)
  end
end
