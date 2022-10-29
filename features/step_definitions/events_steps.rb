
Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    Event.create event
  end
end

Then /I should see all the events/ do
  # Make sure that all the movies in the app are visible in the table
  Event.all.each do |event|
    step %{I should see "#{event.title}"}
  end
end