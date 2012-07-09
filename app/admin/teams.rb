ActiveAdmin.register Team do
    actions :all, :except => [:new, :edit]
end
