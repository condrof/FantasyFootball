ActiveAdmin.register Team do
    actions :all, :except => [:new, :edit]

  collection_action :zeroTeamPoints, :method => :get do
    @teams=Team.all
    @teams.each do |team|
      team.update_attributes(:points => 0)
    end
    redirect_to admin_teams_path, :notice => "TEAM POINTS SET TO 0!"
  end

  collection_action :updateTeamPoints, :method => :get do
    @teams=Team.all
    @teams.each do |team|
      team_points=0
      team.players.each do |player|
        team_points+=player.points
      end
      team.update_attributes(:points => team_points)
    end
    redirect_to admin_teams_path, :notice => "TEAM POINTS UPDATED!"
  end
  
  collection_action :lockAllTeams, :method => :get do
    @teams=Team.all
    @teams.each do |team|
      team.toggle!(:lock)
    end
    redirect_to admin_teams_path, :notice => "ALL TEAMS LOCKED!"
  end

 member_action :lock, :method => :get do
    team =Team.find(params[:id])
    team.toggle!(:lock)
    redirect_to admin_teams_path, :notice => "#{team.teamname} lock status set to #{team.lock}!"
  end
    
  index do
    column :teamname do |team| link_to team.teamname, team_path(team) end
    column :user do |team| link_to team.user.username, user_path(team.user) end
    column :points
    column :league
    column :lock
    
    default_actions
  end
end
