class Later < ApplicationRecord
  belongs_to :recruit, optional: :true

  validates :start_at_hour_top, :start_at_minute_top, :start_at_hour_bottom, :start_at_minute_bottom, :end_at_hour_top, :end_at_minute_top, :end_at_hour_bottom, :end_at_minute_bottom, :close_condition_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: '入力が正常ではありません' }
end
