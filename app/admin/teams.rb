ActiveAdmin.register Team do
    actions :all, :except => [:new, :edit]
    
  index do
    column :teamname
    column :user
    column :points
    
    default_actions
  end
end
