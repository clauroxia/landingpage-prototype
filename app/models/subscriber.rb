# frozen_string_literal: true

require 'httparty'

class Subscriber < ApplicationRecord
  def has_one_preference
    errors.add(:base, 'You should choose at least one preference') if preferences.empty?
  end

  def quality_score
    base_uri = "https://emailvalidation.abstractapi.com/v1/"
    response= HTTParty.get("#{base_uri}?api_key=#{ENV["ABSTRACT_API_KEY"]}&email=#{self[:email]}", no_follow: true)
    if response["quality_score"].to_f < 0.7
      self.errors.add(:base, "You should try enter an valid email")
    end
  end 
  #Association
  has_and_belongs_to_many :preferences, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :email,
  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/,
            message: "must have an email format" }
  validate :has_one_preference
  validate :quality_score
end
