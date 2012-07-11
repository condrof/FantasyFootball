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
      redirect_to users_path
    end
  end
  
  def edit
    @players = Player.search(params[:search]).page(params[:page]).per(10)
    @relationship = @team.team_players.build
  end
  
  def destroy
    @team.destroy
    flash[:alert] = "Team deleted!"
    redirect_to user_path(current_user)
  end
end
