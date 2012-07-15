class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_mailbox
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body
  
  has_many :teams, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  
  validates :username, :uniqueness => true, :presence => true
  
  after_initialize :default_values

  private
    def default_values
      self.admin ||= "false"
      self.moderator ||= "false"
      self.lock ||= "false"
    end

end
