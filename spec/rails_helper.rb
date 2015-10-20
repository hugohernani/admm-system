# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'factory_girl'
require "faker"
require 'shoulda/matchers'
require 'database_cleaner'
require 'pry'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  # config.before(:suite) { DatabaseCleaner.clean_with :truncation }
  # config.before(:each) { DatabaseCleaner.strategy = :transaction }
  # config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }

  config.before(:each, type: :controller) do
    sign_in(current_user)
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
end

def current_user
  create(:user)
end
