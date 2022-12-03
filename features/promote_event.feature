# POC: @rl3250

Feature: Promote event
  As a user and a host
  So that I can promote my events

Background: events in database
  Given the following events exist:
    | title                 | host              | event_time              | status | joined | attendee_limit |
    | Enjoy Lunch at Junzi  | Daemon Targaryen  | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |
    | Gym                   | Testuser          | 2022-10-30 00:00:00 UTC | open   | 1      | 2 |

  Given the following users exist:
    | username          | password  | email                      | coins |
    | Daemon Targaryen  | dt123     | daemontargaryen@gmail.com  | 100   |
    | Testuser           | test      | test@test.com             |  3    |

Scenario: successfully promoted event
  Given I signed in as "Daemon Targaryen" with "dt123"
  When I am on the event details page for "Enjoy Lunch at Junzi"
  And I follow "Promote"
  Then I should see "promoted!"

Scenario: failed to promote event
  Given I signed in as "Testuser" with "test"
  When I am on the event details page for "Gym"
  And I follow "Promote"
  Then I should see "You don't have enough coins!"

