require 'json'  # parse people array

Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    event[:people] = event[:people].to_s.strip.split(',') if !event[:people].nil?
    event[:attendee_limit] = 1 if event[:attendee_limit].nil?
    Event.create event
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

Given /I hacked in as "([^"]*)"$/ do |username|
  @user = User.create!({:username => username, :password => 'test'})
  visit '/login'
  fill_in "username", :with => "foo"
  fill_in "password", :with => "foo"
  click_button "Login"
end

Given /I hosted the event "([^"]*)"$/ do |title|
    Event.create!({:title => title, :host => @user.username, :joined => 0})
end

Given /I joined the event "([^"]*)"$/ do |title|
  step %{I am on the home page}
  step %{I follow "#{title}"}
  step %{I follow "Join"}
end


Then /the Maximum Number of Attendees of event "([^"]*)" should be "([^"]*)"$/ do |title, value|
  event = Event.find_by(title: title)
  expect(event.attendee_limit).to eq(value.to_i)
 end

# helper method for printing the page to browser for debugging
And /I debug$/ do
  save_and_open_page
end
