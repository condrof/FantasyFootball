class TeamPlayersController < ApplicationController
    load_and_authorize_resource
    rescue_from ActiveRecord::RecordNotUnique, :with => :my_rescue_method
    rescue_from ActiveRecord::RecordInvalid, :with => :too_many_players
  
  def create
    @team = Team.find(params[:team_player][:team_id])
    @relationship = @team.team_players.build(params[:team_player])
    if @relationship.save!
      flash[:alert] = "Player added to team!"
      redirect_to edit_team_path(@team)
    else
      redirect_to edit_team_path(@team)
    end
  end
    
  def destroy
    @team=@team_player.team
    @team_player.destroy
    flash[:alert] = "Player deleted from team!"
    redirect_to edit_team_path(@team)
  end

protected

 def my_rescue_method
   flash[:alert] = "ERROR: Player is already on your team"
   redirect_to edit_team_path(@team)
 end
 
 def too_many_players
    flash[:alert] = "You already have 11 players in your team"
    redirect_to :back
  end
end