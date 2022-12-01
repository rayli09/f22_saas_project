FactoryGirl.define do
    factory :event do
        id '1'
        title 'Lunch'
        host 'David'
        people ['Ben']
        attendee_limit 2
        event_time '05-Nov-2022'
        status 0
    end
  end