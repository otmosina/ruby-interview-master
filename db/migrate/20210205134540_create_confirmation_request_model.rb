class CreateConfirmationRequestModel < ActiveRecord::Migration[5.2]
  def change
    create_table :confirmation_requests do |t|
      t.column :email, :citext, null: false
      t.column :confirmation_sent_at, :timestamptz, default: nil
    
      t.timestamps
    end
  end
end
