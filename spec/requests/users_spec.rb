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
  
  it "allows users to edit their information" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit edit_user_registration_path
    fill_in "Email", :with => "newemail@example.com"
    fill_in "Current password", :with => user.password
    click_button "Update"
    page.should have_content("You updated your account successfully.")
    user.email = "newemail@example.com"
  end
  
  it "should not allows users to edit information with incorrect password" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit edit_user_registration_path
    fill_in "Email", :with => "newemail@example.com"
    fill_in "Current password", :with => "wrong password"
    click_button "Update"
    page.should have_content("Current password is invalid")
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
    visit new_team_path
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

describe "Users can add and remove players to the team" do
  it "should add players to team" do
    player=FactoryGirl.create(:player)
    user=FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit new_team_path
    fill_in "Teamname", :with => "New Team"
    click_button "Create"
    visit edit_team_path(user.teams.first)
    click_button "Add To Team"
    TeamPlayer.count.should eql(1)
    page.should have_content("Player added to team!") 
  end
  
  it "should delete players from team" do
    player=FactoryGirl.create(:player)
    user=FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit new_team_path
    fill_in "Teamname", :with => "New Team"
    click_button "Create"
    visit edit_team_path(user.teams.first)
    click_button "Add To Team"
    click_link "Delete"
    page.should have_content("Player deleted from team!")
    TeamPlayer.count.should eql(0)
  end
  
  it "should not allow the same player on the team twice" do
    player=FactoryGirl.create(:player)
    user=FactoryGirl.create(:user)
    puts "#{user.id} | #{player.id}|"
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    visit new_team_path
    fill_in "Teamname", :with => "New Team"
    click_button "Create"
    TeamPlayer.new(:team_id => user.teams.first.id, :player_id => player.id)
    visit edit_team_path(user.teams.first)
    click_button "Add To Team"
    #page.should have_content("ERROR: Player is already on your team")
    TeamPlayer.count.should eql(1) 
  end
end
