require 'rails/generators/active_record'

class DeviseHackerTrackerGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  desc "Generates a model and migration with the given NAME to store failed sign in attempts and adds to the devise configuration."

  class_option :uuid, desc: "Enable uuid as the index for NAME table", type: :boolean, default: false

  def setup_hacker_tracker_configuration
    devise_initializer_path = "config/initializers/devise.rb"
    if File.exist?(devise_initializer_path)
      old_content = File.read(devise_initializer_path)

      if old_content.match(Regexp.new(/^\s# ==> Configuration for :hacker_tracker\n/))
        false
      else
        inject_into_file(devise_initializer_path, :before => "  # ==> Configuration for :confirmable\n") do
" # ==> Configuration for :hacker_tracker
  # Amount of time an IP address stays blocked for
  # config.ip_block_time = 5.minutes
  #
  # Total number of failed sign in attempts allowed per IP address before being blocked
  # config.maximum_attempts_per_ip = #{Devise.maximum_attempts_per_ip}
  #
  # Total number accounts a single IP address is allowed to attempt before being blocked
  # config.maximum_accounts_attempted = #{Devise.maximum_accounts_attempted}
  #
  # The name of the table storing the failed sign in attempts
  config.sign_in_failures_table_name = '#{table_name}'

"
        end
      end
    end
  end

  def setup_hacker_tracker_locales
    copy_file "../../../config/locales/en.yml", "config/locales/devise_hacker_tracker.en.yml"
  end

  def create_hacker_tracker_migration
    @uuid_enabled = options.uuid
    migration_template "migration.rb", "db/migrate/devise_create_#{table_name}.rb"
  end

end
