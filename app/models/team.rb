class Team < ActiveRecord::Base
  attr_accessible :points, :teamname
  
  belongs_to :user
end
