# POC: @jenniferduan45

Feature: Login user
  As a registered user
  So that I can login to the website

Background: events in database
  Given the following events exist:
    | title                | host             | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | rl               | rl    | daemontargaryen@gmail.com |

Scenario: registered user logs in
  When I go to the log_in page
  And I fill in "Username" with "rl"
  And I fill in "Password" with "rl"
  And I press "Login"
  Then I should be on the welcome page

Scenario: cannot login with empty fields
  When I go to the log_in page
  And I press "Login"
  Then I should be on the login page
  And I should see "fields cannot be null"
  
Scenario: a new user successfully uses Google to SSO login
  When I go to the login_signup page
  And I perform Google SSO