class Player < ActiveRecord::Base
  attr_accessible :club, :games, :goals, :name, :points, :position
end
