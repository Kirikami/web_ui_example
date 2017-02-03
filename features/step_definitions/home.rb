Given /^I navigate to (.*) page$/ do |page|
    on(HomePage).send("go_to_#{page}")
end

Then /^I (should|should not) see (.*) page$/ do |should, page|
  if should == 'should'
    expect(on(page).have_logo?).to be_truthy
  else
    expect(on(page).have_logo?).to be_falsey
  end
end

