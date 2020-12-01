class Recruit < ApplicationRecord
  belongs_to :user
  has_one :later, dependent: :destroy
  has_one :now, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries


  #募集中かどうか
  def self.recruit?(user)
    Recruit.find_by(user_id: user.id)
  end
  
end
