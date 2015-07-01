FactoryGirl.define do
  factory :sign_in_failure do
    user_email "test@eg.com"
    ip_address  "1.2.3.4"
  end
end