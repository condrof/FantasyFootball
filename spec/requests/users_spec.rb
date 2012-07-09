require 'spec_helper'

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit new_user_registration_path
    fill_in "Email",                 :with => "foo@example.com"
    fill_in "Password",              :with => "secret"
    fill_in "Password confirmation", :with => "secret"
    click_button "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
  end
end
  
describe "user sign in" do
  it "allows users to sign in after they have registered" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.email
    click_button "Sign in"
    page.should have_content("Signed in successfully.")
  end
end

describe "user admin sign in" do 
  it "should not allow users to access admin path if non admin" do
    user = FactoryGirl.create(:user, :admin => "false")
    visit new_user_session_path
    fill_in "Email",    :with => "foo@example.com"
    fill_in "Password", :with => "secret"
    click_button "Sign in"  
    visit "/admin"
    page.should have_content("This area is restricted to administrators only.")
  end
  
  it "should allow admin users access dashboard" do
    user=FactoryGirl.create(:user, :admin => "true")
    visit new_user_session_path
    fill_in "Email",    :with => "foo@example.com"
    fill_in "Password", :with => "secret"
    click_button "Sign in"  
    visit "/admin"
    page.should have_selector('h2', :text => 'Dashboard')
  end
  
  it "should sign out successfully" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    visit new_user_session_path
    fill_in "Email",    :with => "foo@example.com"
    fill_in "Password", :with => "secret"
    click_button "Sign in" 
    visit destroy_user_session_path
    page.should have_content("Signed out successfully.")
  end
end  
  
describe "user can create teams" do
  it "should allow users to create teams" do
    user=FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => "alindeman2@example.com"
    fill_in "Password", :with => "ilovegrapes"
    click_button "Sign in"
    visit new_team_path
    page.should have_content("Create New Team")
  end
end
