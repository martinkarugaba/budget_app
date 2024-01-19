# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
  end
end
