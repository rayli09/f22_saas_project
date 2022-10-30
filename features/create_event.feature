# POC: @jenniferduan45

Feature: Create event
  As a user
  So that I can create and post a new event

Background: events in database
  Given the following events exist:
    | title                | host             | rating  | event_time              | status | joined |
    | Enjoy Lunch at Junzi | Daemon Targaryen | 4.9/5.0 | 2022-10-30 00:00:00 UTC | open   | 1      |

Scenario: the user successfully posts a new event
  Given I logged in as "TestUser"
  When I go to the post event page
  Then I should see "Post New Event"
  When I fill in "Title" with "Test Party Event"
  And I fill in "Maximum Number of Attendees" with "4"
  And I press "Post Event"
  Then I should be on the home page
  And I should see "Test Party Event"

Scenario: the user fails to post a new event because of empty title value
  Given I logged in as "TestUser"
  When I go to the post event page
  Then I should see "Post New Event"
  When I fill in "Maximum Number of Attendees" with "4"
  And I press "Post Event"
  Then I should be on the post event page
  And I should see "Field 'Title' must be correctly filled in."

Scenario: the user cancels the new event
  Given I logged in as "TestUser"
  When I go to the post event page
  Then I should see "Post New Event"
  When I fill in "Title" with "Test Party Event"
  And I fill in "Maximum Number of Attendees" with "4"
  And I follow "Cancel"
  Then I should be on the home page
  And I should not see "Test Party Event"
