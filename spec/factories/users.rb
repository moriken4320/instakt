FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.free_email }
    password {  Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    provider { Faker::Lorem.characters(number: 10) }
    uid { Faker::Lorem.characters(number: 10) }
  end
end
