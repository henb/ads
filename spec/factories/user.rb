require 'faker'

FactoryGirl.define do

  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "test#{n}.#{Faker::Internet.safe_email}" }

    password '11111111'
    password_confirmation '11111111'

    factory :guest_user do
      role 'guest'
    end

    factory :user_user do
      role 'user'
    end

    factory :admin_user do
      role 'admin'
    end

  end
end
