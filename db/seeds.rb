# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

events = [
        {:title => 'Go To Gym today afternoon', :host => 'Alicent Hightower', :joined =>'0', :people => [], :status => 0, :description => 'Working out is important', :event_time => '02-Nov-2022', :attendee_limit => 2},
        {:title => 'Enjoy Lunch at Junzi', :host => 'Daemon Targaryen', :joined =>'1', :people => ['Mysaria'], :status => 0, :description => 'Let\'s eat together', :event_time => '30-Oct-2022', :attendee_limit => 4},
        {:title => 'Lunch at Max Cafe', :host => 'Mysaria', :joined =>'3', :people => ['Alicent Hightower', 'Daemon Targaryen', 'testuser'], :status => 1, :description => 'Sandwich and coffee!', :event_time => '05-Nov-2022', :attendee_limit => 5},
        {:title => 'WTF', :host => 'testuser', :joined =>'3', :people => ['Alicent Hightower', 'Daemon Targaryen', 'Mysaria'], :status => 1, :description => 'WTF IS THIS!', :event_time => '05-Nov-2022', :attendee_limit => 20},
				{:title => 'Crazy Party', :host => 'Amy Hsu', :joined =>'5', :people => ['Mysaria', 'Daemon Targaryen', 'Alicent Hightower', 'testuser', 'Jackson Wang'], :status => 0, :description => 'Enjoy the EDM', :event_time => '20-Nov-2022', :attendee_limit => 10},
]

events.each do |event|
  Event.create!(event)
end

users = [
        {:username => 'Alicent Hightower', :password_digest => '12345', :rating => 5},
				{:username => 'Daemon Targaryen', :password_digest => '67890', :rating => 4},
				{:username => 'Mysaria', :password_digest => '11324', :rating => 3},
				{:username => 'testuser', :password_digest => '55648', :rating => 4},
        {:username => 'Amy Hsu', :password_digest => 'amy666', :rating => 3},
        {:username => 'Jackson Wang', :password_digest => '142857', :rating => 2},
]

users.each do |user|
  User.create!(user)
end
