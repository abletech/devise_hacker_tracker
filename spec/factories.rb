FactoryGirl.define do
  factory :sign_in_failure do
    email "test@eg.com"
    another_key 'testing'
    ip_address  "1.2.3.4"
  end
end