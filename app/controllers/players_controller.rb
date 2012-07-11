class PlayersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @players = Player.search(params[:search]).page(params[:page]).per(10)
  end
  
  def show
  end
 
end
