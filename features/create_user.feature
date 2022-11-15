# POC: @jenniferduan45

Feature: Create user
  As a new user
  So that I can sign up and create new user info

Background: events in database
  Given the following events exist:
    | title                | host             | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | Daemon Targaryen | dt123    | daemontargaryen@gmail.com |

Scenario: a new user successfully creates user info
  When I go to the new user page
  And I fill in "Username" with "newUser"
  And I fill in "Password" with "pass123"
  And I press "Create User"
  Then I should be on the welcome page

Scenario: a new user fails to create user info due to duplicate username
  When I go to the new user page
  And I fill in "Username" with "Daemon Targaryen"
  And I fill in "Password" with "password123"
  And I press "Create User"
  Then I should be on the new user page
  And I should see "username already exists"

Scenario: a new user successfully uses Google to SSO login
  When I go to the login_signup page
  And I follow "Log In with Google"
  Then I should be on the login_signup page
  And I should see "Choose an account"