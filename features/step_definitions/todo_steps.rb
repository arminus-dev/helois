module AdminDashboardHelpers
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
end

World(AdminDashboardHelpers)

def user
  @user ||= User.make
end

def login
  user
  visit '/login'
  fill_in("Email", :with => user.email)
  fill_in("Password", :with => user.password)
  click_button("Login")
end

Given /^the following todos:$/ do |todos|
  Todo.create!(todos.hashes)
end


When /^I delete the (\d+)(?:st|nd|rd|th) todo$/ do |pos|
  visit todos_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following todos:$/ do |expected_todos_table|
  pending
  #expected_todos_table.diff!(tableish('table tr', 'td,th'))
end


Given /^I am on the new user page$/ do
  visit path_to("the new user page")
end


Given /^I am on the new todo page$/ do
  visit path_to("the new todo page")
end

Then /^I should see error messages$/ do
  visit path_to("the new user page")
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Given /^I am signed up as "(.+)\/(.+)"$/ do |email, password|
  Factory(:user, :email => email, :password => password, :password_confirmation => password)
end

Given /^I am logged out$/ do
  begin
    click_link("Sign out")
  rescue Capybara::ElementNotFound
  end
end

Then /^I should be logged in$/ do
  page.should_not have_content("Sign In")
end

Then /^I should be logged out$/ do
  visit path_to("the todo page")
  page.should have_content("Login")
end


Given /^I sign in as "([^"]*)"$/ do |value|
  visit path_to("the sign in page")
  fill_in(:Email, :with => value.split("/").first)
  fill_in(:Password, :with => value.split("/").last)
  click_button("Sign in")
end

%w{notice success error}.each do |selector|
  Then /^(?:|I )should see #{selector} flash message "([^"]*)"$/ do |message|
    visit path_to("the home page")
  end
end

Given /^I sign in as an user$/ do
  visit path_to("the sign in page")
  fill_in(:Email, :with => 'solaiman.shaikh@arminus.co.in')
  fill_in(:Password, :with => 'arminus')
  click_button("Sign in")
end

Given /^I am on the todo page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^should see data with following tabular values:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
