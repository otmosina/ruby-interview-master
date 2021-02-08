class AddConfirmationReleatedTimestampsToCredential < ActiveRecord::Migration[5.2]
  def change
    add_column :email_credentials, :confirmation_sent_at, :timestamptz, default: nil
  end
end
