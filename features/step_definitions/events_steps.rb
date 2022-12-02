require 'json'  # parse people array

Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    event[:people] = event[:people].to_s.strip.split(',') if !event[:people].nil?
    event[:attendee_limit] = 1 if event[:attendee_limit].nil?
    Event.create event
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Then /I should see all the events/ do
  # Make sure that all the events in the app are visible in the table
  Event.all.each do |event|
    "I should see '#{event.title}'"
  end
end
  
Given /I logged in as "([^"]*)"$/ do |username|
    @user = User.create!({:username => username, :password => 'test'})
    visit '/login'
    fill_in "username", :with => username
    fill_in "password", :with => "test"
    click_button "Login"
end

Given /I signed in as "([^"]*)" with "([^"]*)"$/ do |username, password|
  visit '/login'
  fill_in "username", :with => username
  fill_in "password", :with => password
  click_button "Login"
end

Given /I hacked in as "([^"]*)"$/ do |username|
  @user = User.create!({:username => username, :password => 'test'})
  visit '/login'
  fill_in "username", :with => "foo"
  fill_in "password", :with => "foo"
  click_button "Login"
end

And /I fill in "([^"]*)" Event Time with "([^"]*),([^"]*),([^"]*)"$/ do |title, year, month, day|
  event = Event.find_by(title: title)
  visit "/events/#{event.id}/edit"
  select year, :from => 'event_event_time_1i'
  select month, :from => 'event_event_time_2i'
  select day, :from => 'event_event_time_3i'
  fill_in "Maximum Number of Attendees",:with => 4
end

Then /the Maximum Number of Attendees of event "([^"]*)" should be "([^"]*)"$/ do |title, value|
  event = Event.find_by(title: title)
  expect(event.attendee_limit).to eq(value.to_i)
 end

# helper method for printing the page to browser for debugging
And /I debug$/ do
  save_and_open_page
end

# make sure all the comments of an event are visible
Then /I should see all the comments of "([^"]*)"$/ do |title|
  event = Event.find_by(title: title)
  event.comments.all.each do |comment|
    "I should see '#{comment.content}'"
  end
end

Given /I commented the event "([^"]*)" with "([^"]*)"$/ do |title, content|
  step %{I am on the event details page for "#{title}"}
  step %{I fill in "comment[content]" with "#{content}"}
  step %{I press "Post Comment"}
end

Then /^I should not see "([^"]*)" button/ do |name|
  should have_no_button name
end

Then /^I should see "([^"]*)" button/ do |name|
  find_button(name).should_not be_nil
end