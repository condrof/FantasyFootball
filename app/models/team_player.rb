class TeamPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  
  belongs_to :player
  belongs_to :team

  validate :count, :on => :create

  def count
    if self.team.team_players(:reload).size >= 11
      errors.add(:base, "Exceeded thing limit")
    end
  end

end
