# POC: @jenniferduan45

Feature: Edit event
  As a user
  So that I can edit the events that I host and cannot edit the events that I don't host

Background: events in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |
    | TestEvent            | testuser          | 2022-12-28 00:00:00 UTC | open   | 10     | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | Daemon Targaryen | dt123    | daemontargaryen@gmail.com |

Scenario: the user successfully updates his own event's Maximum Number of Attendees
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "TestEvent"
  Then I should see "Edit"
  Then I follow "Edit"
  And I should see "Edit Event"
  Then I fill in "Maximum Number of Attendees" with "4"
  And I fill in "TestEvent" Event Time with "2022,December,28"
  And I press "Update Event Info"
  Then I should be on the event details page for "TestEvent"
  Then the Maximum Number of Attendees of event "TestEvent" should be "4"

Scenario: the user fails to update his own event's Maximum Number of Attendees
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "TestEvent"
  Then I should see "Edit"
  Then I follow "Edit"
  And I should see "Edit Event"
  Then I fill in "Maximum Number of Attendees" with ""
  And I press "Update Event Info"
  Then I should be on the edit event page for "TestEvent"
  And I should see "Field 'Maximum Number of Attendees' must be correctly filled in."

Scenario: the user fails to update his own event's Event Time
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "TestEvent"
  Then I should see "Edit"
  Then I follow "Edit"
  And I should see "Edit Event"
  Then I fill in "Maximum Number of Attendees" with "4"
  And I fill in "TestEvent" Event Time with "2022,October,15"
  And I press "Update Event Info"
  Then I should be on the edit event page for "TestEvent"
  And I should see "Field 'Event Time' must be correctly filled in."

Scenario: the user cannot edit the event that he doesn't host
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "Enjoy Lunch at Junzi"
  Then I should not see "Edit"