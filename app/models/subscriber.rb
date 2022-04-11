class Subscriber < ApplicationRecord
#Association
has_one :preference, dependent: :destroy

#Validations
validates :email, presence: true, uniqueness: true
validates :email,
format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/,
          message: "must have an email format" }
          # format: {with: URI::MailTo::EMAIL_REGEXP}
end
