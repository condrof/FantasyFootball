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
  
  factory :category do
    id 100
    title "Category"
  end
  
  factory :forum do
    title "New Forum"
    description "desc"
    id 100
    category_id 100
  end
  
  factory :topic do
    id 100
    title "topic"
    body "post"
    forum_id 100
    user
  end
  
  factory :post do
    body "New post"
    forum_id 100
    topic_id 100
    user
  end
  
  factory :league do
    name "first"
    lock "false"
  end
end
