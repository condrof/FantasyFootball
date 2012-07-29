class TeamPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  
  belongs_to :player
  belongs_to :team

  before_validation :count
  before_validation :value


  def count
    if self.team.team_players(:reload).size >= 11
      errors.add(:team_player, "Exceeded team limit")
    end
  end
  
  def value
    val=0.0
    self.team.players.each do |t|
        val += t.value.to_f
    end
    if val >= 50.0
      errors.add(:team_player, "Team value exceeded")
    end  
  end 
  
  def goalkeeper
    gk=0
    self.team.players.each do |player| 
      if player.position == "Goalkeeper"
        gk += 1
      end
    end
      errors.add(:team_player, "Too many keepers") if gk > 0
  end

  def defender
    defe=0
    self.team.players(:reload).each do |player| 
      if player.position == "Defender"
        defe += 1
      end
    end
      errors.add(:team, "Too many Defenders") if defe >= 5
  end
  
  def midfield
    count=0
    self.team.players(:reload).each do |player| 
      if player.position.eql?("Midfield")
        count += 1
      end
    end
    if count > 4
      errors.add(:team, "Too many Midfield")
    end
  end
  
  def forward
    count=0
    self.team.players(:reload).each do |player| 
      if player.position == "Forward"
        count += 1
      end
    end
    if count > 2
      errors.add(:team, "Too many Forwards")
    end
  end
end
