# frozen_string_literal: true

require "httparty"

class Subscriber < ApplicationRecord
  def has_one_preference
    errors.add(:preferences, I18n.t("messages.errors.preferences_not_selected")) if preferences.empty?
  end

  def quality_score
    base_uri = "https://emailvalidation.abstractapi.com/v1/"
    response = HTTParty.get("#{base_uri}?api_key=#{ENV['ABSTRACT_API_KEY']}&email=#{self[:email]}", no_follow: true)
    errors.add(:email, I18n.t("messagges.errors.score_not_valid")) if response["quality_score"].to_f < 0.7
  end
  # Association
  has_and_belongs_to_many :preferences, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/,
                      message: I18n.t("messges.errors.format_not_valid") }, unless: proc { |a|
                                                                                a.email.blank?
                                                                              }
  validate :has_one_preference, unless: proc { |a| a.email.blank? }
  validate :quality_score, unless: proc { |a| a.email.blank? }
end
