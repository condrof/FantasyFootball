class Team < ActiveRecord::Base
  attr_accessible :points, :teamname, :league_id
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :league
 
  has_many :team_players, :dependent => :destroy
  validates_each :team_players do |tp, attr, value|
    tp.errors.add attr, "More players on team than allowed" if tp.players.count >= 11
  end
    
  
  has_many :players, :through => :team_players
  
  validates :teamname, :uniqueness => true, :presence => true
  
 after_initialize :default_values

  private
    def default_values
      self.points ||= 0
      self.lock ||= "false"
    end
    
end
