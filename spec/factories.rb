FactoryGirl.define do |f|
  factory :user do
    id 2
    email "foo@example.com"
    password "secret"
  end
  
  factory :team do
    teamname "My team"
    user
  end 
end
