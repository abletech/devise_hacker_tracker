require 'rails/generators/active_record'

class DeviseSignInFailuresGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def setup
    Devise.model_name = table_name.singularize unless table_name.blank?

    devise_initializer_path = "config/initializers/devise.rb"
    if File.exist?(devise_initializer_path)
      old_content = File.read(devise_initializer_path)

      if old_content.match(Regexp.new(/^\s# ==> Configuration for :sign_in_failures\n/))
        false
      else
        inject_into_file(devise_initializer_path, :before => "  # ==> Configuration for :confirmable\n") do
          id_response = ask "What is the name of a unique identifier on your #{table_name} table? (default: '#{Devise.model_identifier}')"
          type_response = ask "What is the name the type of the #{Devise.model_name} #{Devise.model_identifier} attribute? (default: '#{Devise.model_identifier_type}')"
" # ==> Configuration for :sign_in_failures
  # Note: Do not change these config fields unless you have changed these fields in the database
  #
  # The name of the devise model you are using
  # config.model_name = #{Devise.model_name}
  #
  # A unique identifer for the devise model you are using
  # config.model_identifier = #{Devise.model_identifier}
  # The type of the unique model_identifier used
  # config.model_identifier_type = #{Devise.model_identifier_type}

"
        end
      end
    end
  end

  def create_sign_in_failures_migration
    migration_template "migration.rb", "db/migrate/devise_create_sign_in_failures.rb"
  end

end
