ActiveAdmin.register Team do
    actions :all, :except => [:new, :edit]
    
  index do
    column :teamname do |team| link_to team.teamname, team_path(team) end
    column :user do |team| link_to team.user.username, user_path(team.user) end
    column :points
    
    default_actions
  end
end
