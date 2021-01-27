# frozen_string_literal: true

class User < ApplicationRecord
  has_one :email_credential

  accepts_nested_attributes_for :email_credential

  scope :active, -> { where(deleted_at: nil) }
end
