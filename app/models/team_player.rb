class TeamPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  
  belongs_to :player
  belongs_to :team

  validate :count, :on => :create
  validate :team_value, :on => :create
  validate :goalkeeper, :on => :create
  validate :defender, :on => :create
  validate :midfield, :on => :create
  validate :forward, :on => :create


  def count
    if self.team.team_players(:reload).size >= 11
      errors.add(:base, "Exceeded team limit")
    end
  end
  
  def team_value
    val=0
    self.team.players.each do |t|
        val += t.value.to_i
    end
    if val > 50
      errors.add(:base, "Team value exceeded")
    end  
  end 
  
  def goalkeeper
    count=0
    self.team.players.each do |player| 
      if player.position == "Goalkeeper"
        count += 1
      end
    end
      errors.add(:team, "Too many keepers") if count > 0
  end

  def defender
    count=0
    self.team.players.each do |player| 
      if player.position == "Defender"
        count += 1
      end
    end
    if count > 4
      errors.add(:base, "Too many keepers")
    end
  end
  
  def midfield
    count=0
    self.team.players.each do |player| 
      if player.position == "Midfield"
        count += 1
      end
    end
    if count > 4
      errors.add(:base, "Too many keepers")
    end
  end
  
  def forward
    count=0
    self.team.players.each do |player| 
      if player.position == "Forward"
        count += 1
      end
    end
    if count > 2
      errors.add(:base, "Too many keepers")
    end
  end
end
