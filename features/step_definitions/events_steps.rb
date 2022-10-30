require 'json'  # parse people array
require 'capybara'

Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    event[:people] = event[:people].to_s.strip.split(',') if !event[:people].nil?
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
  password = 'test'
  # use webdriver, need to start the server
  #session = Capybara::Session.new(:selenium)
  #session.visit 'http://localhost:3000/login'
  #session.fill_in 'username', visible: false, with: username
  #session.fill_in 'password', visible: false, with: password

  # not working bc the field is invisible
  get '/login'
  fill_in 'username', :with => username
  fill_in 'password', :with => password
  click_button "Login"
end 
