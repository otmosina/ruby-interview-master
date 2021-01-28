# frozen_string_literal: true

class User < ApplicationRecord
  include Tokenable
  has_one :email_credential

  accepts_nested_attributes_for :email_credential

  scope :active, -> { where(deleted_at: nil) }

  after_create :send_confirmation_email

  def send_confirmation_email
    #GEENRATE TOKEN 
    #WRITE TOKEN TO DB
    #COMPOSE EMAIL
    #EMAIL SENDING

    puts "#{self.token} =========================> send_confirmation_email DONE"
    puts "Link to cofirm #{self.compose_comfirmation_link}"
  end

  def confirm_token!
    return true
  end

  private

  CONFIRMATION_URL = "https://example.com"
  def compose_comfirmation_link
    return [CONFIRMATION_URL, "token=#{self.token }"].join("?")
  end
end
