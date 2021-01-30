# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  has_secure_password

  belongs_to :user
  CONFIRMATION_TTL_HOURS = 48
  def change_state!
    self.update_attribute(:state, 'active')
  end

  def mark_sent_confirmation!
    self.confirmation_sent_at = DateTime.now
    self.save
  end

  def is_confirmation_link_has_expire?
    return Datetime.now.to_i - self.confirmation_sent_at.to_i > CONFIRMATION_TTL_HOURS.days.to_i
  end
end
