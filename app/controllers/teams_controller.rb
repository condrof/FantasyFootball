class TeamsController < ApplicationController
  load_and_authorize_resource
  
  def show
  end
  
  def new
    if signed_in?
      @team = current_user.teams.build
    else
      flash[:notice] = "You must be signed in to continue"
      redirect_to root_path
    end
  end
  
  def create
    @team = current_user.teams.build(params[:team])
    if @team.save
      flash[:alert] = "Team created!"
      redirect_to edit_team_path(@team)
    else
      flash[:alert] = "Team Name already taken"
      redirect_to new_team_path
    end
  end
  
  def edit
    @players = Player.search(params[:search]).page(params[:page]).per(10)
    @relationship = @team.team_players.build
  end

  def update
    if @team.update_attributes(params[:team])
      flash[:notice] = "Team was successfully updated."
      redirect_to edit_team_path(@team)
    end
  end
  
  def destroy
    @team.destroy
    flash[:alert] = "Team deleted!"
    redirect_to user_path(current_user)
  end
end
