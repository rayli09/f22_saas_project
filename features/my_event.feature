# POC: @Mandydidi

Feature: show all my events
  As a user
  So that I can see my history of hosting/joining evetns

Background: events in database

  Given the following events exist:
  | title                     | rating  | host              | joined     |  people          |
  | Go To Gym today afternoon | 4.9/5.0 | Alicent Hightower | 19 |                  |
  | Enjoy Lunch at Junzi2      | 4.9/5.0 | Daemon Targaryen  | 10 |  "Mysaria"  |
  | Lunch at Max Cafe         | 4.8/5.0 | Mysaria           | 2 |      "Alicent Hightower"   |

Scenario: the user who didn't host or join any event
  Given I logged in as "TestUser"
  When I go to the myEvents page
  Then I should see "You haven't hosted any event"
  And I should see "You haven't joined any event"
  And I should see "HOST NOW"
  And I should see "JOIN NOW"

Scenario: the user hosted and joined some events
  Given I logged in as "Alicent Hightower"
  When I go to the myEvents page
  Then I should see "Go To Gym today afternoon"
  And I should see "Lunch at Max Cafe"

  