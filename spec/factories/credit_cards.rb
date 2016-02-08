FactoryGirl.define do
  factory :credit_card do
    last_four_digits 1234
    billing_address1 "MyString"
    billing_address2 "MyString"
    billing_city "MyString"
    billing_state "MyString"
    billing_zip 27701
  end
end
