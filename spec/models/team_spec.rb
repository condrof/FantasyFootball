require 'spec_helper'

describe Team do

  let(:user) { FactoryGirl.create(:user) }
  before { @team = user.teams.build(teamname: "New team") }

  subject { @team }

  it { should respond_to(:teamname) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @team.user_id = nil }
    it { should_not be_valid }
  end
  
describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Team.new(user_id: user.id).should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end    
  end
end
