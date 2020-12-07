FactoryBot.define do
  factory :message do
    text {"aaaaa"}
    association :sender, factory: :user, strategy: :create
    association :room, factory: :recruit, strategy: :create

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
