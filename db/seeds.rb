100.times do
  Book.create!(title: Faker::Book.title,
              published_date: Faker::Date.between(30.days.ago, Date.today),
              author: Faker::Book.author,
              price: Faker::Commerce.price,
              category: Faker::Book.genre,
              description: Faker::Lorem.sentence
              )
end


User.create!(email: "rwajnberg@gmail.com",
            password: "password",
            confirmed_at: Date.today
            )

20.times do
  User.create!(email: Faker::Internet.email,
              password: Faker::Internet.password(8),
              )
end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password')

20.times do
  PendingPurchase.create!(
    user_id: rand(1...21),
    book_id: rand(1...100),
    price_at_purchase: rand(1...100),
    quantity: 1
   )
end
