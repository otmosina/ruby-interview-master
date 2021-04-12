# frozen_string_literal: true

class RemoveTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, ["token"]
    remove_column :users, :token
  end
end
