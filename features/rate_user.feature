Feature: Rate User

  As a event attendee/host
  So that I can rate my attendee/host

Background: events in database

  Given the following events exist:
    | title                     | host              | joined     |  people    | attendee_limit  |
    | TestEvent1                | Alicent Hightower | 19         |            | 2               |
    | TestEvent2                | Daemon Targaryen  | 10         |  testuser  | 2               |

  Given the following users exist:
    | username          | password | email                      |
    | Alicent Hightower | ah456    | alicenthightower@gmail.com |
    | Daemon Targaryen  | dt123    | daemontargaryen@gmail.com  |

Scenario: attendee can rate host
  Given I logged in as "testuser"
  And I am on the event details page for "TestEvent1"
  And I follow "Join"
  And I go to the logout page

  Given I signed in as "Alicent Hightower" with "ah456"
  And I am on the event details page for "TestEvent1"
  And I follow "Edit"
  And I select "closed" from "Status"
  And I press "Update Event Info"
  And I go to the logout page

  Given I signed in as "testuser" with "test"
  And I am on the event details page for "TestEvent1"
  And I follow "Rate your host"
  And I select "1" from "Alicent Hightower"
  And I press "Submit"
  And I should be on the event details page for "TestEvent1"

Scenario: host can rate attendee
  Given I logged in as "testuser"
  And I am on the event details page for "TestEvent1"
  And I follow "Join"
  And I go to the logout page

  Given I signed in as "Alicent Hightower" with "ah456"
  And I am on the event details page for "TestEvent1"
  And I follow "Edit"
  And I select "closed" from "Status"
  And I press "Update Event Info"
  And I go to the event details page for "TestEvent1"
  And I follow "Rate your attendees"
  And I select "1" from "testuser"
  And I press "Submit"
  And I should be on the event details page for "TestEvent1"
  

