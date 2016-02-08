100.times do
  Book.create!(title: Faker::Book.title,
               published_date: Faker::Date.between(30.days.ago, Date.today),
               author: Faker::Book.author,
               price: rand(1000...10000),
               category: Faker::Book.genre,
               description: Faker::Lorem.sentence
              )
end


User.create!(email: "rwajnberg@gmail.com",
             password: "password",
             confirmed_at: Date.today
            )

# 20.times do
#   User.create!(email: Faker::Internet.email,
#               password: Faker::Internet.password(8),
#               )
# end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password'
                 )
