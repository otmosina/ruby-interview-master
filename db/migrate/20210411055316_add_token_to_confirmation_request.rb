# frozen_string_literal: true

class AddTokenToConfirmationRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :confirmation_requests, :token, :string, default: nil
    add_index :confirmation_requests, :token, unique: true
  end
end
