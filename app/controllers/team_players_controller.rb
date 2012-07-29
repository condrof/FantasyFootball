class TeamPlayersController < ApplicationController
    load_and_authorize_resource
    rescue_from ActiveRecord::RecordNotUnique, :with => :my_rescue_method
    rescue_from ActiveRecord::RecordInvalid, :with => :too_many_players
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
          
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
    @team_player=TeamPlayer.find(params[:id])
    @team_player.destroy
    flash[:alert] = "Player deleted from team!"
    redirect_to :back
  end

protected

 def my_rescue_method
   flash[:alert] = "ERROR: Player is already on your team"
   redirect_to edit_team_path(@team)
 end
 
 def too_many_players
   val = 0
    if @team.players.count >= 11
      flash[:alert] = "You already have 11 players in your team"
    elsif @team.players.each do |t| 
      val += t.value.to_f
        if val>1.0
          flash[:alert] = "Team Value is above 50m"
        end
      end
    else
      flash[:alert] = "Player can not be added to team"
    end
    redirect_to :back
  end
  
  def record_not_found
    redirect_to :back
  end
end