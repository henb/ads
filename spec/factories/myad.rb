FactoryGirl.define do

  factory :myad do
    sequence(:title) {|i| "#{Faker::Name.title}#{i}" }
    description Faker::Lorem.paragraph
  end

end