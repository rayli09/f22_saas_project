FactoryGirl.define do
    factory :event do
        id '1'
        title 'Lunch'
        host 'David'
        people ['Ben']
        attendee_limit 2
    end
  end