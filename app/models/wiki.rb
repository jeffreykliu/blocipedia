class Wiki < ActiveRecord::Base
  
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :user

  scope :visible_to, -> (user) { user ? all : where(private: nil) || where(private: false) }


  def owned_by?(user)
    self.user_id == user.id
  end

end
