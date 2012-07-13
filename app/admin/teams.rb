ActiveAdmin.register Team do
    actions :all, :except => [:new, :edit]
    
  index do
    column :teamname do |team| link_to team.teamname, team_path(team) end
    column :user
    column :points
    
    default_actions
  end
end
