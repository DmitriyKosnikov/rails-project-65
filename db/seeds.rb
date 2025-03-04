10.times do
  Category.create(name: Faker::Food.ethnic_category)
end
