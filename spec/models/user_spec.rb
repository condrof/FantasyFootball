require 'spec_helper'

describe User do
  before do
    @user = User.new(id: 1, email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end
  subject { @user }
  #it { should respond_to(:authenticate) }
  it { should respond_to(:teams) }
end
