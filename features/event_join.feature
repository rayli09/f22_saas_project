# POC: @rl3250
Feature: Join event

  As a event attendee
  So that I can join/unjoin a new event

Background: events in database

  Given the following events exist:
  | title                     | rating  | host              | joined     |  people    | attendee_limit  |
  | TestEvent1                | 4.9/5.0 | Alicent Hightower | 19         |            | 2               |
  | TestEvent2                | 4.9/5.0 | Daemon Targaryen  | 10         |  testuser  | 2               |

Scenario: attendee can join event
  Given I logged in as "testuser"
  And I am on the event detail page of 'TestEvent1'
  # And I debug
  And I follow "Join"
  Then I should see "Unjoin"
  And I should see "You've joined it!"

# TODO #20
Scenario: attendee can unjoin event
  Given I logged in as "testuser"
  And I am on the event detail page of 'TestEvent2'
  # And I debug
  Then I follow "Unjoin"
  And I should see "You've unjoined it."


