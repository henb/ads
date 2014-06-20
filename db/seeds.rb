# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Typead.delete_all
User.delete_all
Myad.delete_all
Image.delete_all

30.times do 
  typ = Typead.new(name: Faker::Lorem.words.join, description:Faker::Lorem.paragraph)
  typ.save
end

type = Typead.all

# create admin
admin = User.new(
    first_name: "Admin",
    last_name:  "Hello",
    email:      "admin@gmail.com",
    password:              "11111111",
    password_confirmation: "11111111")
admin.role = "admin"
admin.save  

#create users and ads
5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    email:      Faker::Internet.safe_email,
    password:              "11111111",
    password_confirmation: "11111111")

  if user.save  
    15.times do
      ad = user.myads.new(
            title:       Faker::Name.title,
            description: Faker::Lorem.paragraph,
            typead:   type[rand(type.size)])
      ad.save
    end

    user.myads[2..-1].each {|ad| ad.fresh}
    user.myads[3..5].each  {|ad| ad.reject}
    user.myads[6..8].each {|ad| ad.ban}
    user.myads[8..-1].each {|ad| ad.approve}
    user.myads[11..-1].each {|ad| ad.publish}
    user.myads[13..-1].each {|ad| ad.archive}
  end

end