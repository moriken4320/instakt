class RecruitLater
  include ActiveModel::Model
  attr_accessor(
    :user,
    :start_at_hour_top,
    :start_at_minute_top,
    :start_at_hour_bottom,
    :start_at_minute_bottom,
    :end_at_hour_top,
    :end_at_minute_top,
    :end_at_hour_bottom,
    :end_at_minute_bottom,
    :place,
    :message,
    :close_condition_count)
  
  validates :user, presence: true
  validates :start_at_hour_top, :start_at_hour_bottom, :end_at_hour_top, :end_at_hour_bottom, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 23}
  validates :start_at_minute_top, :start_at_minute_bottom, :end_at_minute_top, :end_at_minute_bottom, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :place, :message, length: { maximum: 20 }
  validates :close_condition_count, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 15}
  
  
  def save
    recruit = Recruit.create(user_id: user.id, close_flag: 0, close_condition_count:close_condition_count)
    Later.create(
      start_at_hour_top: start_at_hour_top,
      start_at_minute_top: start_at_minute_top,
      start_at_hour_bottom: start_at_hour_bottom,
      start_at_minute_bottom: start_at_minute_bottom,
      end_at_hour_top: end_at_hour_top,
      end_at_minute_top: end_at_minute_top,
      end_at_hour_bottom: end_at_hour_bottom,
      end_at_minute_bottom: end_at_minute_bottom,
      place: place,
      message: message,
      recruit_id: recruit.id
    )
  end

  def update(recruit)
    recruit.update(close_condition_count:close_condition_count)
    recruit.later.update(
      start_at_hour_top: start_at_hour_top,
      start_at_minute_top: start_at_minute_top,
      start_at_hour_bottom: start_at_hour_bottom,
      start_at_minute_bottom: start_at_minute_bottom,
      end_at_hour_top: end_at_hour_top,
      end_at_minute_top: end_at_minute_top,
      end_at_hour_bottom: end_at_hour_bottom,
      end_at_minute_bottom: end_at_minute_bottom,
      place: place,
      message: message,
    )
  end
  
  
end