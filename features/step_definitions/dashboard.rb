# noinspection CucumberDuplicatedStep
When /^I click on edit button for (.*)$/ do |button|
  on(DashboardPage).edit button
end

When /^I change (.*) to (.*)/ do |info, data|
  on(DashboardPage).update info, data
end

When /^I sign out$/ do
  on(DashboardPage).log_out
end

Then /^I should see (.*) changed$/ do |info|
  expect(on(DashboardPage).has_changed_information? info).to be_truthy
end