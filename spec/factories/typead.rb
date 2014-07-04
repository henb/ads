FactoryGirl.define do

  factory :typead do
    sequence(:name) { |i| "#{Faker::Name.title}#{i}" }
    description Faker::Lorem.paragraph
  end

end
