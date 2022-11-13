# POC: @jenniferduan45

Feature: Create event
  As a user
  So that I can create and post a new event

Background: events in database
  Given the following events exist:
    | title                | host             | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

Scenario: a new use creates user info
  When I go to the new user page
  And I press "Create User"
  Then I should be on the welcome page

