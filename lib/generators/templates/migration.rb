class DeviseCreateSignInFailures < ActiveRecord::Migration
  def change
    create_table(:sign_in_failures, id: :uuid) do |t|
      t.uuid :<%= table_name.singularize %>_id
      t.inet :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
