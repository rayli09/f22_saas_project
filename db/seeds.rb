# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

events = [{:title => 'Go To Gym today afternoon', :host => 'Alicent Hightower', :rating => '4.9/5.0', :joined =>'0', :people => [], :status => 0, :description => 'Working out is important', :event_time => '02-Nov-2022', :attendee_limit => 2},
    	  {:title => 'Enjoy Lunch at Junzi', :host => 'Daemon Targaryen', :rating => '4.9/5.0', :joined =>'1', :people => ['Mysaria'], :status => 0, :description => 'Let\'s eat together', :event_time => '30-Oct-2022', :attendee_limit => 4},
    	  {:title => 'Lunch at Max Cafe', :host => 'Mysaria', :rating => '4.8/5.0', :joined =>'3', :people => ['Alicent Hightower', 'Daemon Targaryen', 'Aemon Targaryen'], :status => 1, :description => 'Sandwich and coffee!', :event_time => '05-Nov-2022', :attendee_limit => 5},
  	 ]

events.each do |event|
  Event.create!(event)
end 
