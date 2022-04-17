# frozen_string_literal: true

require "httparty"

class Subscriber < ApplicationRecord
  # Association
  has_and_belongs_to_many :preferences, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/ },
                    if: proc { |a| a.errors.messages_for(:email).empty? }
  validate :quality_score, if: proc { |a| a.errors.messages_for(:email).empty? }
  validate :one_preference?, if: proc { |a| a.errors.messages_for(:email).empty? }

  # Custom Validations
  def one_preference?
    return unless preferences.empty?

    errors.add(:preferences, I18n.t("activerecord.errors.messages.preferences_not_selected"))
  end

  def quality_score
    base_uri = "https://emailvalidation.abstractapi.com/v1/"
    response = HTTParty.get("#{base_uri}?api_key=#{ENV['ABSTRACT_API_KEY']}&email=#{self[:email]}", no_follow: true)
    return unless response["quality_score"].to_f < 0.7

    errors.add(:email, I18n.t("activerecord.errors.messages.score_not_valid"))
  end
end
