# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

events = [{:title => 'Go To Gym today afternoon', :host => 'Alicent Hightower', :rating => '4.9/5.0', :joined =>'0'},
    	  {:title => 'Enjoy Lunch at Junzi', :host => 'Daemon Targaryen', :rating => '4.9/5.0', :joined =>'1'},
    	  {:title => 'Lunch at Max Cafe', :host => 'Mysaria', :rating => '4.8/5.0', :joined =>'5'},
  	 ]

events.each do |event|
  Event.create!(event)
end