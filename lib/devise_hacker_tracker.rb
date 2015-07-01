require "devise_hacker_tracker/version"
require 'devise_hacker_tracker/hooks/hacker_tracker'
require 'devise_hacker_tracker/models/hacker_tracker'

Devise.add_module :hacker_tracker, :model => 'devise_hacker_tracker/models/hacker_tracker'

module Devise
  mattr_accessor :model_name
  @@model_name = 'user'

  mattr_accessor :model_identifier
  @@model_identifier = 'email'

  mattr_accessor :model_identifier_type
  @@model_identifier_type = 'string'

  mattr_accessor :ip_block_time
  @@ip_block_time = 5.minutes

  mattr_accessor :maximum_attempts_per_ip
  @@maximum_attempts_per_ip = 5

  mattr_accessor :maximum_accounts_attempted
  @@maximum_accounts_attempted = 3


  def self.model_identifer_column_name
    "#{@@model_name}_#{@@model_identifier}"
  end

  def self.model_class
    @@model_name.capitalize.safe_constantize
  end
end
