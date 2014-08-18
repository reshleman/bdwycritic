class User < ActiveRecord::Base
  has_many :user_reviews

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
