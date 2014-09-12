FactoryGirl.define do
  factory :user do
    first_name "Hugh"
    last_name "Jackman"
    email "hugh@jackman.com"
    password_digest "password"

    factory :admin_user do
      admin true
    end
  end
end
