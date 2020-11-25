FactoryBot.define do
  factory :relationship do
    association :follower, factory: :user, strategy: :create
    association :following, factory: :user, strategy: :create
  end
end
