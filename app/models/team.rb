class Team < ActiveRecord::Base
  attr_accessible :points, :teamname
  validates :user_id, presence: true
  belongs_to :user
end
