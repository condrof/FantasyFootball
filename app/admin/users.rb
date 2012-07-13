ActiveAdmin.register User do
  actions :all, :except => [:new, :edit]
  
  member_action :set_admin, :method => :get do
    user = User.find(params[:id])
    user.toggle!(:admin)
    redirect_to admin_users_path, :notice => "#{user.email} admin status set to #{user.admin}!"
  end

  index do
    column :email do |user| link_to user.email, user_path(user) end
    column :admin
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    column "Toggle Admin", :id do |id|
      link_to "Make Admin", set_admin_admin_user_path(id), data: { confirm: "You sure?" }
    end
    default_actions
  end
end
