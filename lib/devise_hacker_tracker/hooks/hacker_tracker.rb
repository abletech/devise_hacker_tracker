require 'warden'

Warden::Manager.before_failure do |env, options|
  if options.try(:[], :action) == "unauthenticated" && options.has_key?(:recall)
    request = ActionDispatch::Request.new(env)

    attributes = { ip_address: request.remote_ip, user_agent: request.user_agent }
    authentication_values =  request.params.try(:[], options.try(:[], :scope))

    Devise.authentication_keys.each do |key|
      attributes = attributes.merge(key => authentication_values.try(:[], key))
    end
    SignInFailure.create!(attributes)
  end
end
