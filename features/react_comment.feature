# POC: @Mandydidi

Feature: React to comment
  As a user
  So that I can react to a comment

Background: events in database
  Given the following events exist:
    | title                | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

  Given the following users exist:
    | username         | password | email                     |
    | Daemon Targaryen | dt123    | daemontargaryen@gmail.com |

Scenario: the user reacts thumbup to a comment
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  And I press "thumbup"
  Then I should see "TestUser, and others"
  And I should see "1 Reactions"
  And I should not see "like" button
  And I should not see "laugh" button

Scenario: the user cancels the previous thumbup to a comment
  Given I logged in as "TestUser"
  And I commented the event "Enjoy Lunch at Junzi" with "Test Comment"
  And I press "thumbup"
  And I press "thumbup"
  Then I should see "Be the first one to react"
  And I should see "like" button
  And I should see "laugh" button