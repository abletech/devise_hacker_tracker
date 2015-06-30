require "devise_sign_in_failures/version"
require 'devise_sign_in_failures/hooks/sign_in_failures'
require 'devise_sign_in_failures/models/sign_in_failure'

Devise.add_module :sign_in_failures, :model => 'devise_sign_in_failures/models/sign_in_failure'