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
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in successfully")
  end
end

describe "user admin sign in" do 
  
  it "should sign out successfully" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in" 
    visit destroy_user_session_path
    page.should have_content("Signed out successfully.")
  end
end  
  
describe "user can create teams" do
  it "should allow users to create teams" do
    user=FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit teams_path
    fill_in "Teamname", :with => "New Team"
    click_button "Create"
    page.should have_content(user.teams.last.teamname)
  end
end

describe "Create and delete teams" do
  it "should destroy associated teams" do
    user=FactoryGirl.create(:user)
    FactoryGirl.create(:team, user_id: user.id)
    teams = user.teams
    user.destroy
    teams.each do |team|
      Team.find_by_id(team.id).should be_nil
    end
  end
end
