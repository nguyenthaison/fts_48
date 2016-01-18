require "faker"
FactoryGirl.define do
  sequence(:email){Faker::Internet.email}
  sequence(:chatwork_id){Faker::Lorem.words}
  password = Faker::Lorem.characters(10)
  factory :user do
    name Faker::Name.name
    chatwork_id
    role 0
    email
    password password
    password_confirmation password

    factory :admin do
      role 1
    end
  end
end
