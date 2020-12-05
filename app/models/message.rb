class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :room, class_name: "Recruit"
  has_one_attached :image

  validates :text, presence: true, unless: :was_attached?
    
  def was_attached?
    self.image.attached?
  end
end
