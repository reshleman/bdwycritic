FactoryGirl.define do
  factory :user do
    first_name "Hugh"
    last_name "Jackman"
    email "hugh@jackman.com"
    password_digest "password"

    trait :admin do
      admin true
    end
  end
end
