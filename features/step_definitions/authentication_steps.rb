Given(/^I have an account on the site$/) do
  visit root_path
  click_on "Sign up"
  fill_in 'Email', with: 'newestuser@test.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_on 'Sign up'
end

Given(/^My account is confirmed$/) do
  ctoken = ActionMailer::Base.deliveries.last.body.match(/confirmation_token=\w*/)
  visit "/users/confirmation?#{ctoken}"
  user = User.find_for_authentication(email: 'newestuser@test.com')
  expect(user).to be_confirmed
end

When(/^I enter my correct email$/) do
  fill_in 'Email', with: 'newestuser@test.com'
end

When(/^I enter my password$/) do
  fill_in 'Password', with: 'password'
end

When(/^I enter the wrong password$/) do
  fill_in 'Password', with: 'xyz'
end

Then(/^I am notified that my password is incorrect$/) do
  expect(page).to have_content("Invalid email or password.")
end
