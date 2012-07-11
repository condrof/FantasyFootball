class Player < ActiveRecord::Base
  attr_accessible :club, :games, :goals, :name, :points, :position
  
  has_many :team_players, :dependent => :destroy
  has_many :teams, :through => :team_players
end
