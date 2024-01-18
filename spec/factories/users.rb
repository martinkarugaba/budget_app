# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Internet.name }
    email { Faker::Internet.email }
    password { 'password123' }
  end
end
