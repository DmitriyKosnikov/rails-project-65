IMAGES_NAMES = %w[restaurant_1.jpg restaurant_2.jpg restaurant_3.jpg restaurant_5.jpg restaurant_6.jpg].freeze

# 15.times do
#   Category.create(name: Faker::Food.ethnic_category)
# end

# 10.times do
#   User.create(
#     name: Faker::Name.name,
#     email: Faker::Internet.email
#   )
# end

100.times do
  bulletin = Bulletin.create(
    title: Faker::Restaurant.name,
    description: Faker::Restaurant.description,
    user_id: User.all.sample.id,
    category_id: Category.all.sample.id,
    state: Bulletin.aasm.states.sample.name
  )

  name_img = IMAGES_NAMES.sample
  bulletin.image.attach(
    io: File.open(Rails.root.join("seeds/images/#{name_img}").to_s),
    filename: name_img,
    content_type: 'image/jpeg'
  )
  bulletin.save
end
