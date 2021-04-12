# frozen_string_literal: true

class RemoveColumnConfirmedSentAtFromEmailCredentials < ActiveRecord::Migration[5.2]
  def change
    remove_column :email_credentials, :confirmation_sent_at
  end
end
