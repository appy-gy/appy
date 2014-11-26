FactoryGirl.define do
  factory :rating do
    sequence(:title) { |n| "Rating #{n}" }
  end
end
