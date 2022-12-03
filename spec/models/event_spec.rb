require 'rails_helper'

RSpec.describe Event, type: :model do
    describe "#find_event_by_name" do
        it "should return a event by title" do
            event1 = Event.create! :title => 'Event A'
            event2 = Event.create! :title => 'Event B'
            expect(Event.find_event_by_name("Event")).to include(event1, event2)
        end

        it "should return a event by host name" do
            event1 = Event.create! :host => 'Host A'
            event2 = Event.create! :host => 'Host B'
            expect(Event.find_event_by_name("Host")).to include(event1, event2)
        end

        it "should return a event by attendee name" do
            event1 = Event.create! :people => ['person A']
            event2 = Event.create! :people => ['person B']
            expect(Event.find_event_by_name("person")).to include(event1, event2)
        end

        it "shouldn't return a event when host name is not matched" do
            event1 = Event.create! :host => 'Event A'
            event2 = Event.create! :host => 'Event B'
            expect(Event.find_event_by_name("foo")).not_to include(event1, event2)
        end
    end
    describe "promotion_banner_style" do
        it "should return special css for promoted event" do
            e1 = Event.create! :title => 'Event A', :promoted? => true
            expect(e1.promotion_banner_style).to eq('table-success')
        end
        it "should not have any styling for unpromoted event" do
            e2 = Event.create! :title => 'Event B', :promoted? => false
            expect(e2.promotion_banner_style).to eq('')
        end
    end
end