# frozen_string_literal: true

require "httparty"

class Subscriber < ApplicationRecord
  def one_preference?
    return unless preferences.empty?

    errors.add(:preferences,
               I18n.t("messages.errors.preferences_not_selected"))
  end

  def quality_score
    base_uri = "https://emailvalidation.abstractapi.com/v1/"
    response = HTTParty.get("#{base_uri}?api_key=#{ENV['ABSTRACT_API_KEY']}&email=#{self[:email]}", no_follow: true)
    return unless response["quality_score"].to_f < 0.7

    errors.add(:email,
               I18n.t("messages.errors.score_not_valid"))
  end

  def valid_format
    return if self[:email].match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/)

    errors.add(:email,
               I18n.t("messages.errors.format_not_valid"))
  end
  # Association
  has_and_belongs_to_many :preferences, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validate :valid_format, unless: proc { |a| a.email.blank? }
  validate :quality_score, if: proc { |a| a.errors.messages_for(:email).empty? }
  validate :one_preference?, if: proc { |a| a.errors.messages_for(:email).empty? }
end
