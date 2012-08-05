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
    @q = Player.search(params[:q])
    @players = @q.result(:distinct => true)  #.page(params[:page]).per(40)
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
    @relationship = @team.team_players.build
  end

  def update
    @league=League.find_by_name(params[:team][:league_id])
    if !@league.nil?
      if @team.update_attributes(:league_id => @league.id)
        flash[:alert] = "Team was added to #{@league.name}"
        redirect_to edit_team_path(@team)
      else
        flash[:alert] = "Error adding team to league. Please try again"
        redirect_to edit_team_path(@team)
      end
   else
      flash[:alert] = "League does not exist"
      redirect_to edit_team_path(@team)  
   end 
  end
  
  def destroy
    @team.destroy
    flash[:alert] = "Team deleted!"
    redirect_to user_path(current_user)
  end
 
end
