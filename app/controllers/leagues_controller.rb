class LeaguesController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def show
  end

  def new
    @league=League.new
  end
  
  def create
    @league=League.new(params[:league])
  end
end
