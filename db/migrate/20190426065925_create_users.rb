# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.column :deleted_at, :timestamptz

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
