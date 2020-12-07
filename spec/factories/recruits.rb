FactoryBot.define do
  factory :recruit do
    close_condition_count {1}
    association :user
  end
end
