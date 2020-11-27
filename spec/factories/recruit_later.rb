FactoryBot.define do
  factory :recruit_later do
    start_at_hour_top {"00"}
    start_at_minute_top {"00"}
    start_at_hour_bottom {"00"}
    start_at_minute_bottom {"00"}
    end_at_hour_top {"00"}
    end_at_minute_top {"00"}
    end_at_hour_bottom {"00"}
    end_at_minute_bottom {"00"}
    place {"aaa"}
    message {"aaa"}
    close_condition_count {5}

    association :user
  end
end