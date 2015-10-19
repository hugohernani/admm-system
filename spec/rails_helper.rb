# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl'
require 'shoulda/matchers'
require 'database_cleaner'
require 'pry'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true

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
  create(:repense_core_user)
end
