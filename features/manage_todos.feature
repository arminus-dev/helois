Feature: Manage todos
  After sign up  or sign in user can create their todos.

  Scenario: Register new invalid todo
    Given I am logged in as "solaiman"
    And I am on the new todo page
    When I fill in "Title" with ""
    And I fill in "Expected duration(In hours)" with ""
    And I fill in "Due date" with ""
    And I uncheck "Completed"
    Then I should see error messages

  Scenario: Register new todo
    Given I am logged in as "solaiman"
    And I am on the new todo page
    When I fill in "Title" with "new task"
    And I fill in "Expected duration(In hours)" with "23.0"
    And I fill in "Due date" with "2011-05-16 08:20:13"
    And I uncheck "Completed"
    And I press "Create Todo"

  Scenario: Todo list with searching
    Given I am logged in as "solaiman"
    And I am on the todo page
    Then should see data with following tabular values:
      | Title    | Expected duration  | Due date     | Completed   |
      | sample1  | 2.0                | May 19, 2011 | true        |
      | sample2  | 4.0                | May 19, 2011 | true        |
      | sample3  | 7.0                | May 19, 2011 | false       |
      | sample4  | 3.2                | May 19, 2011 | false       |

   Scenario: Delete todo
     Given I am logged in as "solaiman"
     And the following todos:
       | title    | expected_duration  | due_date     | completed   |
       | sample1  | 2.0                | May 19, 2011 | true        |
       | sample2  | 4.0                | May 19, 2011 | true        |
       | sample3  | 7.0                | May 19, 2011 | false       |
       | sample4  | 3.2                | May 19, 2011 | false       |
     Then I should see the following todos:
       | title    | expected_duration  | due_date     | completed   |
       | sample2  | 4.0                | May 19, 2011 | true        |
       | sample3  | 7.0                | May 19, 2011 | false       |
       | sample4  | 3.2                | May 19, 2011 | false       |