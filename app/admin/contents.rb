ActiveAdmin.register Content do
  controller do
    def create
      @content=Content.new(params[:content])
      if @content.save
         flash[:notice] = "Page successfully created"
         redirect_to admin_contents_path
      else
         redirect_to admin_contents_path      
     end
    end
    
    def update
      @content=Content.find(params[:id])
      @content.update_attributes(params[:content])
      if @content.save
         flash[:notice] = "Page successfully updated"
         redirect_to admin_contents_path
      else
         redirect_to admin_contents_path      
     end
    end
  end
  
  
end
