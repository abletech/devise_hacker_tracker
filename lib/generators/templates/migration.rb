class DeviseCreateSignInFailures < ActiveRecord::Migration
  def change
    create_table(:sign_in_failures, id: :uuid) do |t|
      t.<%= Devise.model_identifier_type %> :<%= Devise.model_identifer_column_name %>
      t.string :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
