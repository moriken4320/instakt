class Now < ApplicationRecord
  belongs_to :recruit

  validates :member_count, :end_at_hour_top, :end_at_minute_top, :end_at_hour_bottom, :end_at_minute_bottom, :close_condition_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: 'の入力が正常ではありません' }
end
