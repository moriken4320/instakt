class RecruitLater
  include ActiveModel::Model
  attr_accessor 
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
    :close_condition_count
  
  
  
  def save
    recruit = Recruit.create(user_id: user.id)
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
      close_condition_count:close_condition_count,
      recruit_id: recruit.id
    )
  end
  
end