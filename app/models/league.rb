class League < ActiveRecord::Base
  
  attr_accessible :name
  
  validates :name, :uniqueness => true, :presence => true
  
  #validates_presence_of :name
  #valides :name, :uniqueness => "true"
  
  has_many :teams
end
