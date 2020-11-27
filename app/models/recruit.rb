class Recruit < ApplicationRecord
  belongs_to :user
  has_one :later, dependent: :destroy
  has_one :now, dependent: :destroy


  #募集中かどうか
  def recruit?(user)
    Recruit.find_by(user_id: user.id)
  end
  
end
