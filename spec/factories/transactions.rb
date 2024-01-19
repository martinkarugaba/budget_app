FactoryBot.define do
  factory :transaction do
    amount { 100.0 }
    name { 'Transaction Name' }
    association :author, factory: :user
    categories { [association(:category)] }
  end
end
