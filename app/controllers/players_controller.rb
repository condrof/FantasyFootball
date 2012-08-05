class PlayersController < ApplicationController
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    @q = Player.search(params[:q])
    @players = @q.result(:distinct => true)  #.page(params[:page]).per(40)
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  def show

  end
  
protected

  def record_not_found
    redirect_to players_path(params)
  end 

end
