
require "authlogic/test_case"

Before do
include Authlogic::TestCase
activate_authlogic
end

def create_user(login)
  @current_user = User.create!(
    :username => login,
    :password => 'generic',
    :password_confirmation => 'generic',
    :email => "#{login}@example.com"
  )
end

def login_user
  visit path_to("the sign in page")
  fill_in("Email", :with => @current_user.email)
  fill_in("Password", :with => 'generic')
  click_button("Sign in")
end

def logout_user
session = UserSession.find
session.destroy if session
end

def user_session
  @session ||= UserSession.find
end


Given /^I am the user "(.*)"$/ do |login|
  create_user login
end

Given /^I am logged in as "(.*)"$/ do |login|
  create_user login
login_user
end

Given /^I am not logged in$/ do
logout_user
end

When /^I Log In$/ do
  login_user
end

When /^I logout$/ do
logout_user
end

Then /^there should be a session$/ do
  user_session
  @session.should_not be nil
end

Then /^there should not be a session$/ do
  user_session
  @session.should be nil
end

Then /^the user should be "([^"]*)"$/ do |login| #"
  user_session
  @session.user.login.should be == login
end