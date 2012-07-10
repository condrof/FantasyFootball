class Player < ActiveRecord::Base
  attr_accessible :club, :games, :goals, :name, :points, :position
  
  has_many :team_players
  has_many :teams, :through => :team_players
end
