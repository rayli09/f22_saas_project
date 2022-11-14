# POC: @Mandydidi

Feature: Delete comment
  As a user
  So that I can delete a comment posted by myself

Background: events and comments in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

Scenario: the user can only delete the comment posted by himself/herself
  Given I logged in as "TestUser1"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  When I follow "Delete"
  Then I should be on the event details page for "Enjoy Lunch at Junzi"
  And I should see "Comment was deleted."
  Given I logged in as "TestUser2"
  And I am on the event details page for "Enjoy Lunch at Junzi"
  Then I should not see "Delete"
  