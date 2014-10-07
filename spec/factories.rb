FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :event do
    description "Carousel is the second musical by Rodgers and Hammerstein."
    name "Carousel"
    venue "Majestic Theatre"
    without_closing_date

    factory :event_with_media_reviews do
      ignore { media_review_count 2 }

      after :create do |instance, evaluator|
        create_list(
          :media_review,
          evaluator.media_review_count,
          event: instance
        )
      end
    end

    factory :event_with_user_reviews do
      ignore { user_review_count 2 }

      after :create do |instance, evaluator|
        create_list(
          :user_review,
          evaluator.user_review_count,
          event: instance
        )
      end
    end

    trait :closed do
      closing_date { 1.day.ago }
    end

    trait :open do
      closing_date { 1.day.from_now }
    end

    trait :without_closing_date do
      closing_date nil
    end
  end

  factory :media_review do
    author "Ben Brantley"
    event
    headline "Praise for a Fantastic Show"
    sentiment 0.9
    source "New York Times"
    url "http://www.nytimes.com"
  end

  factory :user do
    email
    first_name "Hugh"
    last_name "Jackman"
    password_digest "password"

    trait :admin do
      admin true
    end
  end

  factory :user_review do
    body "This was a fantastic show!"
    event
    rating 9
    user
  end
end
