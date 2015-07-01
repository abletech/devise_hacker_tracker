require 'warden'

Warden::Manager.before_failure do |env, options|
  if options.try(:[], :action) == "unauthenticated" && options.has_key?(:recall)
    request = ActionDispatch::Request.new(env)
    model_identifier_value = request.params.try(:[], Devise.model_name).try(:[], Devise.model_identifier)

    SignInFailure.create!(
      "#{Devise.model_identifer_column_name}" => model_identifier_value,
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )
  end
end
