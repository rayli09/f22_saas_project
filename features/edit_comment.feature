# POC: @Mandydidi

Feature: Edit comment
  As a user
  So that I can edit a comment posted by myself

Background: events and comments in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

Scenario: the user can only update his/her posted comment into non-empty string
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  When I follow "Edit"
  And I fill in "comment[content]" with ""
  And I press "Update Comment"
  Then I should see "Comment content shouldn't be empty."
  When I fill in "comment[content]" with "Test comment :)"
  And I press "Update Comment"
  Then I should be on the event details page for "Enjoy Lunch at Junzi"
  And I should see "Comment was successfully updated."
  And I should see "Test comment :)"

Scenario: the user can return to the previous page by cancelling editting
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  When I follow "Edit"
  And I follow "Cancel"
  Then I should be on the event details page for "Enjoy Lunch at Junzi"