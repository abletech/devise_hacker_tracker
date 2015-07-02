$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'devise_hacker_tracker'
require 'database_cleaner'
require 'factory_girl'
require 'factories'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :sign_in_failures, :force => true do |t|
    t.string :email
    t.string :another_key
    t.string :ip_address
    t.string :user_agest

    t.timestamps
  end
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end