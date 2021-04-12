# frozen_string_literal: true

class AddTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, default: nil
    add_index :users, :token, unique: true
  end
end
