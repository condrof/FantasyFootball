FactoryGirl.define do
  sequence(:email) { |n| "foo#{n}@example.com" }
  sequence(:username) { |n| "user#{n}"}
  sequence(:name) { |n| "name#{n}"}

  factory :user do
    username
    email
    password "secret"
    password_confirmation "secret"
    moderator "false"
  end
  
  factory :team do
    teamname Faker::Name.name
    user
  end 
  
  factory :player do
    name
    club "club"
    goals "3"
  end
end
