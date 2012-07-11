class Team < ActiveRecord::Base
  attr_accessible :points, :teamname
  validates :user_id, presence: true
  belongs_to :user
  
  has_many :team_players, :dependent => :destroy
  has_many :players, :through => :team_players
end
