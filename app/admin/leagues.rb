ActiveAdmin.register League do
  controller do
    def create
      @league=League.new(params[:league])
      if @league.save
         flash[:notice] = "Team successfully created"
         redirect_to admin_leagues_path
      else
         redirect_to admin_leagues_path      
     end
    end
    
    def update
      @league=League.find(params[:id])
      @league.update_attributes(params[:league])
      if @league.save
         flash[:notice] = "Team successfully updated"
         redirect_to admin_leagues_path
      else
         redirect_to admin_leagues_path      
     end
    end
  end
  
  index do
    column :name do |l| link_to l.name, league_path(l) end
    column :updated_at
    
    default_actions
  end
end
