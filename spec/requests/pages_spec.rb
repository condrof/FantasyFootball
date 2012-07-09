require 'spec_helper'

describe "Pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/pages/home'
      page.should have_selector('h1', :text => 'Sample App' )
    end
  end
  
  it "should have the right title" do
    visit '/pages/home'
    page.should have_selector('title', :text => "Home")
  end
  
  it "should access the users page" do
    visit users_path
    page.should have_content("Users")
  end
  
  it "should show individual users page" do
    user=FactoryGirl.create(:user)
    visit user_path(user.id)
    page.should have_content(user.email)
  end
end