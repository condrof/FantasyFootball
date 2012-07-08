require 'spec_helper'

describe "Static pages" do

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
end