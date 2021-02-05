# frozen_string_literal: true

class ConfirmationRequest < ApplicationRecord
  CONFIRMATION_TTL_HOURS = 48.hours
  CONFIRMATION_REQUEST_TTL_MINUTES = 5

  def mark_sent_confirmation!
    self.confirmation_sent_at = DateTime.now
    self.save
  end

  def is_confirmation_link_has_expire?
    return DateTime.now.to_i - self.confirmation_sent_at.to_i > CONFIRMATION_TTL_HOURS.to_i
  end

  def is_confirmation_request_has_expire?
    return false if self.confirmation_sent_at.nil?
    return DateTime.now.to_i - self.confirmation_sent_at.to_i < CONFIRMATION_REQUEST_TTL_MINUTES.minutes.to_i
  end

  def is_confirmation_request_valid?
    return true if self.confirmation_sent_at.nil?
    return DateTime.now.to_i - self.confirmation_sent_at.to_i > CONFIRMATION_REQUEST_TTL_MINUTES.minutes.to_i
  end
end
