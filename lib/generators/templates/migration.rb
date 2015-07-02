class DeviseCreate<%= table_name.camelcase %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %><%= ", id: :uuid" if @uuid_enabled %>) do |t|
<% Devise.authentication_keys.each { |key| %><%= "\n      t.string :#{key}" %><% } %>
      t.string :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
