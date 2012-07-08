require 'spec_helper'

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit new_user_registration_path

    fill_in "Email",                 :with => "alindeman@example.com"
    fill_in "Password",              :with => "ilovegrapes"
    fill_in "Password confirmation", :with => "ilovegrapes"

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end
end
  
  
describe "user sign in" do
  it "allows users to sign in after they have registered" do
    user = User.create(:email    => "alindeman@example.com",
                       :password => "ilovegrapes")

    visit new_user_session_path
    
    fill_in "Email",    :with => "alindeman@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end
end

describe "user admin sign in" do 
  it "should not allow users to access admin path if non admin" do
        user = User.create(:email    => "alindeman2@example.com",
                           :password => "ilovegrapes",
                           :admin => "false")
    
    visit new_user_session_path
    
    fill_in "Email",    :with => "alindeman2@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"
    
    visit "/admin"
    
    page.should have_content("This area is restricted to administrators only.")
  end
  
descrive "user can create teams" do
  it "should allow users to create teams" do
            user = User.create(:email    => "alindeman2@example.com",
                           :password => "ilovegrapes",
                           :admin => "false") 
    visit new_user_session_path
    
    fill_in "Email",    :with => "alindeman2@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

  end
end
end
