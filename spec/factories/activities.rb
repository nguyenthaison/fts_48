require "faker"

FactoryGirl.define do
  factory :activity do
    user {FactoryGirl.create :user}
    action [:login, :logout].sample
  end
end
