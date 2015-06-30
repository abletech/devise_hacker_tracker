require "devise_sign_in_failures/version"
require 'devise_sign_in_failures/hooks/sign_in_failures'
require 'devise_sign_in_failures/models/sign_in_failure'

Devise.add_module :sign_in_failures, :model => 'devise_sign_in_failures/models/sign_in_failure'

module Devise
  mattr_accessor :model_name
  @@model_name = 'user'

  mattr_accessor :model_identifier
  @@model_identifier = 'email'

  mattr_accessor :model_identifier_type
  @@model_identifier_type = 'string'

  def self.model_identifer_column_name
    "#{@@model_name}_#{@@model_identifier}"
  end

  def self.model_class
    @@model_name.capitalize.safe_constantize
  end
end
