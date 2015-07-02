class DeviseCreate<%= table_name.camelcase %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
<% Devise.authentication_keys.each { |key| %><%= "\n\t\t\tt.string :#{key}" %><% } %>
      t.string :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
