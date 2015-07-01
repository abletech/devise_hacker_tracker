require 'devise_hacker_tracker/models/sign_in_failure'

module HackerTracker

  def self.hacker?(ip_address)
    SignInFailure.clear_outdated!

    failures = SignInFailure.recent.where(ip_address: ip_address)
    too_many_attempts?(failures) && too_many_accounts_tried?(failures)
  end

  private

  def self.too_many_attempts?(failures)
    failures.size >= Devise.maximum_attempts_per_ip
  end

  def self.too_many_accounts_tried?(failures)
    failures.distinct.count(Devise.model_identifer_column_name) >= Devise.maximum_accounts_attempted
  end

end