FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    password '111111'
    password_confirmation { password }
  end
end
