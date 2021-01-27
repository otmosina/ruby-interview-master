# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  has_secure_password

  belongs_to :user
end
