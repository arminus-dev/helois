Feature: Manage users
  User can resgister with given username, valid email address and password.

  Scenario: Register new user with invalid data
    Given I am on the new user page
    When I fill in "Full Name" with ""
    And I fill in "Email" with "invalid email"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with ""
    And I press "Sign up"
    Then I should see error messages

  Scenario: Register new user with valid data
    Given I am on the new user page
    When I fill in "Full Name" with "solaiman"
    And I fill in "Email" with "solaiman.shaikh@arminus.co.in"
    And I fill in "Password" with "arminus"
    And I fill in "Password confirmation" with "arminus"
    And I press "Sign up"
    Then I should see "Registration successfull."

  Scenario: User signs in successfully
    Given I sign in as "solaiman.shaikh@arminus.co.in/arminus"
    Then I should see notice flash message "Login Successful"
    Then I should be on the home page
    Then I should be logged in

  Scenario: User is not signed up
    Given I sign in as "email@person.com/wrong_password"
    Then I should see error messages
    And I should be logged out
