require 'open-uri'

15.times do
  Category.create(name: Faker::Food.ethnic_category)
end

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end
