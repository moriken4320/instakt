FactoryBot.define do
  factory :entry do
    association :user
    association :recruit
  end
end
