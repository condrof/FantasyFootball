require 'spec_helper'

describe "Forums" do
  describe "GET /forums" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get forums_path
      response.status.should be(200)
    end
  end
  
  describe "post topic" do
    it "should create a new topic" do
      user=FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email",    :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
      visit root_path
      FactoryGirl.create(:category)
      FactoryGirl.create(:forum)
      click_link "Forums"
      click_link "New Forum"
      click_link "New Topic"
      fill_in "Title", :with => "Title"
      fill_in "Body", :with => "Body"
      click_button "submit"
      page.should have_content("Topic was successfully created.")
      Topic.count.should eql(1)
      Post.count.should eql(1)    
    end
  end
end
