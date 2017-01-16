Given /^I navigate to (.*) page$/ do |page|
  if page == 'sign_in'
    on(HomePage).go_to_sign_in
  elsif page == 'sign_up'
    on(HomePage).go_to_sign_in
  else
    $LOG.error("There is no #{page}")
  end
end

Then /^I (should|should not) see (.*) page$/ do |should, page|
  if should == 'should'
    expect(on(page).have_logo?).to be_truthy
  else
    expect(on(page).have_logo?).to be_falsey
  end
end

