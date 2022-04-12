# frozen_string_literal: true

class Subscriber < ApplicationRecord
  def has_one_preference
    errors.add(:base, 'You should choose at least one preference') if preferences.empty?
  end

  # Association
  has_and_belongs_to_many :preferences, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/,
                      message: 'must have an email format' }
  # format: {with: URI::MailTo::EMAIL_REGEXP}
  validate :has_one_preference
end
