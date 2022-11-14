# POC: @Mandydidi

Feature: Create comment
  As a user
  So that I can create and post a new comment

Background: events in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

Scenario: the user posts a valid comment in an event detail page
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  Then I should be on the event details page for "Enjoy Lunch at Junzi"
  And I should see "Comment was successfully created."
  And I should see "Test Comment"

Scenario: the user posts an invalid empty comment in an event detail page
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with ""
  Then I should be on the event details page for "Enjoy Lunch at Junzi"
  And I should see "Comment shoudn't be empty."