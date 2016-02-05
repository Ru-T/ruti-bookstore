FactoryGirl.define do
  factory :credit_card do
    user_id 1
    last_four_digits 1
    billing_address1 "MyString"
    billing_address2 "MyString"
    billing_city "MyString"
    billing_state "MyString"
    billing_zip 1
  end
end
