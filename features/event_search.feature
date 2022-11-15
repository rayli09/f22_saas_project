# POC: @KenXiong123

Feature: search for events by hosts
  As a event host
  So that I can create a new event
  I want to include and search on host information in events I enter

Background: events in database

  Given the following events exist:
  | title                     | host              | joined | attendee_limit |
  | Go To Gym today afternoon | Alicent Hightower | 0      | 2              |
  | Enjoy Lunch at Junzi      | Daemon Targaryen  | 1      | 2              |
  | Lunch at Max Cafe         | Mysaria           | 3      | 2              |

  Given the following users exist:
    | username          | password | email                     |
    | Daemon Targaryen  | dt123    | daemontargaryen@gmail.com |
    | Mysaria           | my456    | mysaria@gmail.com         |

Scenario: see all events on home page
  Given I logged in as "Alicent Hightower"
  When I go to the home page
  Then I should see all the events

Scenario: find event with host name
  Given I logged in as "Alicent Hightower"
  And I am on the home page
  When  I fill in "Search event/host/attendee name" with "Mysaria"
  And   I press "search_result"
  Then  I should be on the search result page
  And   I should see "Lunch at Max Cafe"

