ActiveAdmin.register User do
  actions :all, :except => [:new, :edit]
  
  member_action :set_admin, :method => :get do
    user = User.find(params[:id])
    user.toggle!(:admin)
    redirect_to admin_users_path, :notice => "#{user.email} admin status set to #{user.admin}!"
  end
  
  member_action :set_mod, :method => :get do
    user = User.find(params[:id])
    user.toggle!(:moderator)
    redirect_to admin_users_path, :notice => "#{user.email} moderator status set to #{user.moderator}!"
  end
  
  collection_action :lockAllTeams, :method => :get do
    @users=User.all
    @users.each do |user|
      if !user.lock
        user.toggle!(:lock)
      end
    end
    redirect_to admin_users_path, :notice => "ALL TEAMS LOCKED!"
  end
  
  collection_action :unlockAllTeams, :method => :get do
    @users=User.all
    @users.each do |user|
      if user.lock
        user.toggle!(:lock)
      end
    end
    redirect_to admin_users_path, :notice => "ALL TEAMS UNLOCKED!"
  end

  index do
    column :username do |user| link_to user.username, user_path(user) end
    column :email 
    column :admin
    column :moderator
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    column :lock
    column "Toggle Admin", :id do |id|
      link_to "Make Admin", set_admin_admin_user_path(id), data: { confirm: "You sure?" }
    end
    column "Toggle Moderator", :id do |id|
      link_to "Make Moderator", set_mod_admin_user_path(id), data: { confirm: "You sure?" }
    end
    default_actions
  end
end
