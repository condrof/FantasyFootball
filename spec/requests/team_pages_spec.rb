require 'spec_helper'

describe "TeamPages" do

  describe "team creation" do
    describe "with valid information" do
     it "should create a team" do
      expect {
        user = FactoryGirl.create(:user)
        visit new_user_session_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in" 
        visit new_team_path
        fill_in 'Teamname', with: "Lorem ipsum"
        click_button "Create"
        page.should have_content("Team created!") }.to change{Team.count}.by(1)
      end
      
      it "should delete a team" do
          user = FactoryGirl.create(:user)
          visit new_user_session_path
          fill_in "Email",    :with => user.email
          fill_in "Password", :with => user.password
          click_button "Sign in" 
          visit new_team_path
          fill_in 'Teamname', with: "Lorem ipsum"
          click_button "Create"
          visit user_path(user)
          expect {
            click_link "Delete"
          }.to change{Team.count}.by(-1)
      end
    end
    
    describe "with invalid information" do
      it "should not create a team" do
          visit new_team_path
          page.should have_content("You must be signed in to continue")          
      end
      
      it "should not show another users teams" do
        user=FactoryGirl.create(:user)
        visit new_user_session_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in" 
        visit new_team_path
        fill_in 'Teamname', with: "Lorem ipsum"
        click_button "Create" 
        visit destroy_user_session_path
        user2=FactoryGirl.create(:user)
        visit new_user_session_path
        fill_in "Email",    :with => user2.email
        fill_in "Password", :with => user2.password
        click_button "Sign in" 
        visit team_path(user.teams.first)
        page.should have_content("Access denied.")
      end
    end
  end
end
