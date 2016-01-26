100.times do
  Book.create!(title: Faker::Book.title,
              published_date: Faker::Date.between(30.days.ago, Date.today),
              author: Faker::Book.author,
              price: Faker::Commerce.price,
              category: Faker::Book.genre,
              description: Faker::Lorem.sentence
              )
end
