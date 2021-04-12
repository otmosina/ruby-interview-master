# frozen_string_literal: true

class AddStateToConfirmationRequest < ActiveRecord::Migration[5.2]
  def up
    execute(<<-SQL.squish)
      CREATE TYPE confirmation_requests_states AS ENUM (
        'pending',
        'active'
      );
    SQL
    add_column :confirmation_requests, :state, :confirmation_requests_states, null: false, default: 'pending'
  end

  def down
    remove_column :confirmation_requests, :state
    execute(<<-SQL.squish)
      DROP TYPE confirmation_requests_states;
    SQL
  end
end
