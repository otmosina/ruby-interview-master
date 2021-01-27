# frozen_string_literal: true

class AddUniqueIndexOnEmailToEmailCredentials < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL.squish
      CREATE UNIQUE INDEX email_credentials_email_index
      ON public.email_credentials
      USING btree (email)
      WHERE (deleted_at IS NULL);
    SQL
  end
end
