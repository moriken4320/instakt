FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.free_email }
    password {  Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    provider { Faker::Lorem.characters(number: 10) }
    uid { Faker::Lorem.characters(number: 10) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
