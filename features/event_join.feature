# POC: @rl3250
Feature: Join event

  As a event attendee
  So that I can join/unjoin a new event

Background: events in database

  Given the following events exist:
  | title                     | rating  | host              | joined     |  people          |
  | Go To Gym today afternoon | 4.9/5.0 | Alicent Hightower | 19 |                  |
  | Enjoy Lunch at Junzi2      | 4.9/5.0 | Daemon Targaryen  | 10 |  "testuser"  |
  | Lunch at Max Cafe         | 4.8/5.0 | Mysaria           | 2 |                  |
  | TestEvent                 | 4.8/5.0 | testuser          | 3 |                  |

Scenario: attendee can join event
  Given I am on the home page
  And I follow "Go To Gym today afternoon"
  And I follow "Join"
  Then I should see "Unjoin"
  And I should see "You've joined it!"

# TODO Idk why this fails @KenXiong123

Scenario: attendee can unjoin event
  Given I am on the home page
  And I follow "Go To Gym today afternoon"
  And I follow "Join"
  Then I should see "Unjoin"
  And I should see "You've joined it!"
  Then I follow "Unjoin"
  And I should see "You've unjoined it."


