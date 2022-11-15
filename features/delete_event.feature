# POC: @jenniferduan45

Feature: Delete event
  As a user
  So that I can delete the events that I host and cannot delete the events that I don't host

Background: events in database
  Given the following events exist:
    | title                | host             | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |
    | TestEvent            | testuser         | 2022-11-05 00:00:00 UTC | open   | 10     | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | Daemon Targaryen | dt123    | daemontargaryen@gmail.com |

Scenario: the user successfully deletes his own event
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "TestEvent"
  Then I should see "Delete"
  And I follow "Delete"
  Then I should be on the home page
  And I should see "Event 'TestEvent' was deleted."

Scenario: the user successfully deletes his own event
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "Enjoy Lunch at Junzi"
  Then I should not see "Delete"