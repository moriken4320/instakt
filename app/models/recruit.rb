class Recruit < ApplicationRecord
  belongs_to :user
  has_one :later, dependent: :destroy
  has_one :now, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries

  # 募集が終了している判定
  def close?
    self.close_flag || self.max_entry?
  end
  
  # 参加人数が募集人数を満たしているかどうか
  def max_entry?
    self.entries.length >= self.close_condition_count
  end
  
end
