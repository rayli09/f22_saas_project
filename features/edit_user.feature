# POC: @jenniferduan45

Feature: Edit user
  As a user
  So that I can edit my user profile and cannot edit other user's user profile

Background: events in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |
    | TestEvent            | testuser          | 2022-12-28 00:00:00 UTC | open   | 10     | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | Daemon Targaryen | dt123    | daemontargaryen@gmail.com |

Scenario: the user successfully updates his own user profile's Email
  Given I logged in as "testuser"
  When I go to the myProfile page
  Then I should see "Edit"
  Then I follow "Edit"
  And I should see "Edit User"
  Then I fill in "Email" with "testuser@gmail.edu"
  And I press "Update User Profile"
  Then I should be on the user profile page for "testuser"
  And I should see "User 'testuser' was successfully updated"
  And I should see "testuser@gmail.edu"

Scenario: the user fails to update his own user profile's Email due to invalid format
  Given I logged in as "testuser"
  When I go to the myProfile page
  Then I should see "Edit"
  Then I follow "Edit"
  And I should see "Edit User"
  Then I fill in "Email" with "testuser123"
  And I press "Update User Profile"
  Then I should be on the edit user page for "testuser"
  And I should see "Email must be correctly filled in"

Scenario: the user cannot edit other user's profile
  Given I logged in as "testuser"
  When I go to the home page
  And I follow "Daemon Targaryen"
  Then I should not see "Edit"