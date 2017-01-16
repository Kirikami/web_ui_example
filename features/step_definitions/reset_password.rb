# noinspection CucumberDuplicatedStep
When /^I send reset email from forgot password form$/ do
  on(ResetPasswordPage).send_reset_email
end

Then /^I should see forgot password form$/ do
  expect(on(ResetPasswordPage).have_forgot_password_form?).to be_truthy
end

Then /^I should see successful message$/ do
  expect(on(ResetPasswordPage).have_success_message?).to be_truthy
end