Given /^I am on (.*) page$/ do |page|
  visit page
end

When /^I submit (.*) credentials$/ do |credentials|
  on(LoginPage).sign_in(credentials)
end

When /^I click on forgot password button$/ do
  on(LoginPage).open_forgot_password_form
end

Then /^On (.*) I should see (.*) error message$/ do |page, type|
  expect(on(page).have_error_message? type).to be_truthy
end
