class PlayersController < ApplicationController
  load_and_authorize_resource
  def index
    @players=Player.all
  end
  
  def show
  end
end
