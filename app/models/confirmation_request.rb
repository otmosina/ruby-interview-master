# frozen_string_literal: true

class ConfirmationRequest < ApplicationRecord
  include Tokenable
  CONFIRMATION_URL = "https://example.com"

  CONFIRMATION_TTL_HOURS = 48.hours
  CONFIRMATION_REQUEST_TTL_MINUTES = 5

  include AASM
  aasm column: :state do
    state :pending, initial: true
    state :active

    event :confirm_credential do
      transitions from: :pending, to: :active
    end
  end

  def confirmation_link
    [CONFIRMATION_URL, "token=#{token}"].join("?")
  end

  def mark_sent_confirmation!
    self.confirmation_sent_at = DateTime.now
    save
  end

  def confirmation_link_has_expire?
    DateTime.now.to_i - confirmation_sent_at.to_i < CONFIRMATION_TTL_HOURS.to_i
  end

  def confirmation_request_has_expire?
    return false if confirmation_sent_at.nil?

    DateTime.now.to_i - confirmation_sent_at.to_i < CONFIRMATION_REQUEST_TTL_MINUTES.minutes.to_i
  end

  def self.last_by_email(value)
    ConfirmationRequest.where(email: value).order('created_at DESC').first
  end
end
