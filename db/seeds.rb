# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Contest.destroy_all
Category.destroy_all
User.destroy_all

10.times do
  Category.create(name: Faker::Commerce.department)
end

categories = Category.all

20.times do
  Contest.create(title:     Faker::Commerce.product_name,
                body:       Faker::Lorem.paragraph,
                prize:      Faker::Team.name,
                category:   categories.shuffle.first,
                image:      Faker::Avatar.image,
                end_date:     Faker::Date.between(7.days.from_now, Date.today),
                user:       User.create(password: "a", password_confirmation: "a", company_name: Faker::StarWars.droid, company_address: Faker::StarWars.planet, email: Faker::Internet.email, company_website: Faker::Internet.safe_email, company_phone_number: Faker::PhoneNumber.phone_number))
end
