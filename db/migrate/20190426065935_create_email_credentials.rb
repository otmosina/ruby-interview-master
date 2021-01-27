# frozen_string_literal: true

class CreateEmailCredentials < ActiveRecord::Migration[5.2]
  def up
    execute(<<-SQL.squish)
      CREATE TYPE email_credentials_states AS ENUM (
        'pending',
        'active'
      );
    SQL

    create_table :email_credentials do |t|
      t.column :state, :email_credentials_states, null: false, default: 'pending'
      t.column :email, :citext, null: false
      t.column :password_digest, :text, null: false
      t.column :confirmed_at, :timestamptz
      t.column :deleted_at, :timestamptz
      t.references :user, null: false, index: true, on_delete: :cascade, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end

  def down
    drop_table :email_credentials

    execute(<<-SQL.squish)
      DROP TYPE email_credentials_states;
    SQL
  end
end
