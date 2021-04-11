class RemoveStateToEmailCredential < ActiveRecord::Migration[5.2]
  def change
    remove_column :email_credentials, :state
  end
end
