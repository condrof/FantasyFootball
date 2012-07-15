require 'spec_helper'

describe "Pages" do

  describe "Home page" do
    before { visit root_path }

    it "should have the content 'Fantasy Football'" do
      page.should have_selector('h1', :text => 'Fantasy Football' )
    end
  end
  
  it "should access the users page" do
    visit users_path
    page.should have_content("Users")
  end
  
  it "should show individual users page" do
    user=FactoryGirl.create(:user)
    visit user_path(user.id)
    page.should have_content(user.username)
    page.should have_content(user.teams.count)
  end
  
  it "should access the players page" do
    FactoryGirl.create(:player)
    visit players_path
    page.should have_content("All Players")
  end
  
  it "should access individual players page" do
    player=FactoryGirl.create(:player)
    visit player_path(player.id)
    page.should have_selector('h1', :text => player.name )
  end
end