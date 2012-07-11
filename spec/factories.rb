FactoryGirl.define do
  sequence(:email) { |n| "foo#{n}@example.com" }

  factory :user do
    email
    password "secret"
    password_confirmation "secret"
  end
  
  factory :team do
    teamname Faker::Name.name
    user
  end 
  
  factory :player do
    name Faker::Name.name
    club "club"
    goals "3"
  end
end
