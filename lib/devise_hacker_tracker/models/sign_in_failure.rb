require 'active_record'

class SignInFailure < ActiveRecord::Base
  def self.table_name
    Devise.sign_in_failures_table_name
  end

  scope :recent, -> { where("created_at > '#{Devise.ip_block_time.ago.utc}'") }
  scope :outdated, -> { where("created_at <= '#{Devise.ip_block_time.ago.utc}'") }

  def self.clear_outdated!
    outdated.destroy_all
  end
end
