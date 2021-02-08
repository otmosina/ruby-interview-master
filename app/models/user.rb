# frozen_string_literal: true

class User < ApplicationRecord
  include Tokenable
  has_one :email_credential

  accepts_nested_attributes_for :email_credential

  scope :active, -> { where(deleted_at: nil) }

  CONFIRMATION_URL = "https://example.com"
  
  def confirmation_link
    return [CONFIRMATION_URL, "token=#{self.token }"].join("?")
  end

end
