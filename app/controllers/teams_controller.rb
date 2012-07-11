class TeamsController < ApplicationController
  load_and_authorize_resource
  
  def show
    @team=Team.find(params[:id])
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
      redirect_to user_path(@team.user)
    else
      redirect_to users_path
    end
  end
  
  def destroy
    @team.destroy
    flash[:alert] = "Team deleted!"
    redirect_to user_path(current_user)
  end
end
