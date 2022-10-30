# POC: @KenXiong123

Feature: search for events by hosts
  As a event host
  So that I can create a new event
  I want to include and search on host information in events I enter

Background: events in database

  Given the following events exist:
  | title                     | rating  | host              | joined |
  | Go To Gym today afternoon | 4.9/5.0 | Alicent Hightower | 0      | 
  | Enjoy Lunch at Junzi      | 4.9/5.0 | Daemon Targaryen  | 1      |
  | Lunch at Max Cafe         | 4.8/5.0 | Mysaria           | 3      |

Scenario: see all events on home page
  When I go to the home page
  Then I should see all the events

Scenario: find event with host name
  Given I am on the search page
  When  I fill in "Search event/host/attendee name" with "Mysaria"
  And   I press "search_result"
  Then  I should be on the search result page
  And   I should see "Lunch at Max Cafe"

