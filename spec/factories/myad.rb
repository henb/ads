FactoryGirl.define do

  factory :myad do
    sequence(:title) { |i| "Title: #{Faker::Name.title}#{i}" }
    description Faker::Lorem.paragraph
    typead { create :typead }
    user { create :user }

    factory(:myad_drafting) { state 0 }
    factory(:myad_freshing) { state 1 }
    factory(:myad_rejected) { state 2 }
    factory(:myad_approved) { state 3 }
    factory(:myad_published) { state 4 }
    factory(:myad_archives) { state 5 }
    factory(:myad_banned)   { state 6 }
  end

end
