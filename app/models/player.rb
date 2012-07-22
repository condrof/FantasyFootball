class Player < ActiveRecord::Base
  attr_accessible :club, :games, :goals, :name, :points, :position, :value, :part_appearances, :yellows, :reds, :clean_sheets, :part_clean_sheets, :key_contributions
  
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
