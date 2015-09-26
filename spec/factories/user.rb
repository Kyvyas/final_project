require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    name 'Katya'
    email 'katya@test.com'
    password '12345678'
    password_confirmation '12345678'
  end

 factory :user_2, parent: :user do
    name 'Harry'
    email 'hello@test.com'
    password '12345678'
    password_confirmation '12345678'
 end

 factory :user_3, parent: :user do
    name 'Fred'
    email 'sarah@test.com'
    password '12345678'
    password_confirmation '12345678'
 end
end