# frozen_string_literal: true

class ConfirmationRequest < ApplicationRecord
  include Tokenable
  CONFIRMATION_URL = "https://example.com"
  
  CONFIRMATION_TTL_HOURS = 48.hours
  CONFIRMATION_REQUEST_TTL_MINUTES = 5
  
  def confirmation_link
    return [CONFIRMATION_URL, "token=#{ self.token }"].join("?")
  end

  def mark_sent_confirmation!
    self.confirmation_sent_at = DateTime.now
    self.save
  end

  def is_confirmation_link_has_expire?
    return DateTime.now.to_i - self.confirmation_sent_at.to_i < CONFIRMATION_TTL_HOURS.to_i
  end

  def is_confirmation_request_has_expire?
    return false if self.confirmation_sent_at.nil?
    return DateTime.now.to_i - self.confirmation_sent_at.to_i < CONFIRMATION_REQUEST_TTL_MINUTES.minutes.to_i
  end

  def self.last_by_email value
    ConfirmationRequest.where(email: value).order('created_at DESC').first
  end
end
