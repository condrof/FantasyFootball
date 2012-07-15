class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :layout
  #check_authorization
  
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:alert] = "You do not have sufficient privilages for this action."
      redirect_to root_path
    else
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to root_path
    end
  end
   
  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

protected

  def layout
    i=0
    if user_signed_in?
      current_user.inbox.each do |msg|
        if !msg.opened
          i = i + 1
        end      
      end
    end
    @count = i
  end
end
