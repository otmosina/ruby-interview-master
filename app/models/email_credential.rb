# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  include AASM

  has_secure_password
  belongs_to :user
  
  aasm column: :state do
    state :pending,  initial: true
    state :active
    
    event :confirm_credential do
      transitions from: :pending,  to: :active
    end
  end
end
