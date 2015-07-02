require 'devise'

module Devise
  mattr_accessor :ip_block_time
  @@ip_block_time = 5.minutes

  mattr_accessor :maximum_attempts_per_ip
  @@maximum_attempts_per_ip = 5

  mattr_accessor :maximum_accounts_attempted
  @@maximum_accounts_attempted = 3

  mattr_accessor :sign_in_failures_table_name
  @@sign_in_failures_table_name = 'sign_in_failures'

end

require "devise_hacker_tracker/version"
require 'devise_hacker_tracker/hooks/hacker_tracker'
require 'devise_hacker_tracker/models/hacker_tracker'