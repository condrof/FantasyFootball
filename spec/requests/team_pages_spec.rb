require 'spec_helper'

describe "TeamPages" do

  describe "team creation" do
    describe "with valid information" do
     it "should create a team" do
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email",    :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in" 
      visit teams_path
      fill_in 'Teamname', with: "Lorem ipsum"
      click_button "Create"
      page.should have_content("Lorem ipsum")
      end
    end
  end
end
