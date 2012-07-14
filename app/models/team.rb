class Team < ActiveRecord::Base
  attr_accessible :points, :teamname, :league_id
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :league
  
  has_many :team_players, :dependent => :destroy
  has_many :players, :through => :team_players
  
  validates :teamname, :uniqueness => true, :presence => true
end
