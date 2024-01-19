FactoryBot.define do
  factory :category do
    name { 'Some Category Name' }
    association :user, factory: :user
  end
end
