require 'active_record'

class SignInFailure < ActiveRecord::Base
  scope :recent, -> { where("created_at > '#{Devise.ip_block_time.ago.utc}'") }
  scope :outdated, -> { where("created_at <= '#{Devise.ip_block_time.ago.utc}'") }

  def self.clear_outdated!
    outdated.destroy_all
  end
end
