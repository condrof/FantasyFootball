class Player < ActiveRecord::Base
  attr_accessible :club, :games, :goals, :name, :points, :position
  
  has_many :team_players, :dependent => :destroy
  has_many :teams, :through => :team_players
  
  

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  

end
