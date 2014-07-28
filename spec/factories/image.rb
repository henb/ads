FactoryGirl.define do

  factory :image do
    url 'http://u.henb.by/img'
    myad { create :myad }
  end

end
