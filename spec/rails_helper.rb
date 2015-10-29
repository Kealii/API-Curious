ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'simplecov'
require 'webmock'
require 'vcr'

SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('TWITTER_CONSUMER_KEY') { ENV['TWITTER_CONSUMER_KEY'] }
  config.filter_sensitive_data('TWITTER_CONSUMER_SECRET') { ENV['TWITTER_CONSUMER_SECRET'] }
  config.filter_sensitive_data('TWITTER_USER_TOKEN') { ENV['TWITTER_USER_TOKEN'] }
  config.filter_sensitive_data('TWITTER_USER_SECRET') { ENV['TWITTER_USER_SECRET'] }
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider:           'twitter',
    extra: {
      raw_info: {
        user_id:     '1',
        name:        'Test User',
        screen_name: 'TestScreenName',
      }
    },
    credentials: {
      token:  ENV['TWITTER_USER_TOKEN'],
      secret: ENV['TWITTER_USER_SECRET']
    }
    })
end

def bad_omniauth_credentials
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
end

def login_user
  visit login_path
end