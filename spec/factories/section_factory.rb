FactoryGirl.define do
  factory :section do
    sequence(:name) { |n| "Section #{n}" }
    sequence(:color) { 'red' }
  end
end
