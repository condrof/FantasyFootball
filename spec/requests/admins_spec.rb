require 'spec_helper'

describe "Admins" do
  it "should allow admin users access dashboard" do
    user=FactoryGirl.create(:user, :admin => "true")
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => "secret"
    click_button "Sign in"  
    visit "/admin"
    page.should have_selector('h2', :text => 'Dashboard')
  end
  
    it "should not allow non admin users access dashboard" do
    user = FactoryGirl.create(:user, :admin => "false")
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"  
    visit "/admin"
    page.should have_content("This area is restricted to administrators only.")
  end
  
  it "should allow sample players to be created" do
    user=FactoryGirl.create(:user, :admin => "true")
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => "secret"
    click_button "Sign in" 
    visit samplePlayer_admin_players_path
    page.should have_content("PLAYERS SUCCESSFULLY CREATED!")
  end
  
  it "should update player points" do
    player=FactoryGirl.create(:player)
    user=FactoryGirl.create(:user, :admin => "true")
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => "secret"
    click_button "Sign in" 
    visit updatePlayerPoints_admin_players_path
    page.should have_content("PLAYER POINTS SUCCESSFULLY UPDATED!")
    player.points !=0
  end
  
  it "should zero player points" do
    player=FactoryGirl.create(:player)
    user=FactoryGirl.create(:user, :admin => "true")
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => "secret"
    click_button "Sign in" 
    visit zeroPlayerPoints_admin_players_path
    page.should have_content("PLAYERS POINTS SET TO 0!")
    player.points = 0
   end
end
