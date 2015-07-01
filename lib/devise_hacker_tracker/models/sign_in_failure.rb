class SignInFailure < ActiveRecord::Base
  scope :recent_failed_logins, -> { where("created_at > '#{Devise.ip_block_time.ago}'") }

end
