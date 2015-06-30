require 'rails/generators/active_record'

class DeviseSignInFailuresGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def copy_devise_migration
    migration_template "migration.rb", "db/migrate/devise_create_sign_in_failures.rb"
  end
end
