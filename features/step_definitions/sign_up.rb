When /^I register with (.*) credentials$/ do |credentials|
  on(SignUpPage).sign_up(credentials)
end