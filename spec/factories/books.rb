FactoryGirl.define do
  factory :book do
    title Faker::Book.title
    published_date Faker::Date.between(30.days.ago, Date.today)
    author Faker::Book.author
    price_cents 200
    discount_cents 0
  end
end
