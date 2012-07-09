require 'spec_helper'

describe "TeamPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before {     user=FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in" 
    }

  describe "team creation" do
    before { visit new_team_path }

    describe "with invalid information" do
      it "should not create a team" do
        expect { click_button "Create" }.should_not change(Team, :count)
      end

      describe "error messages" do
        before { click_button "Create" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'teamname', with: "Lorem ipsum" }
      it "should create a team" do
        expect { click_button "Create" }.should change(Team, :count).by(1)
      end
    end
  end
end
