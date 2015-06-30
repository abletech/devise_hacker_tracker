require 'warden'

Warden::Manager.before_failure do |env, options|
  if options.try(:[], :action) == "unauthenticated" && options.has_key?(:recall)
    request = ActionDispatch::Request.new(env)
    record_name = options.try(:[], :scope).to_s
    record_class = record_name.capitalize.safe_constantize
    record = record_class.find_by(email: request.params.try(:[], record_name).try(:[], 'email'))

    SignInFailure.create!("#{record_name}_id": record.try(:id), ip_address: request.remote_ip, user_agent: request.user_agent)
  end
end
