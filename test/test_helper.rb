# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest'
require 'minitest-power_assert'
require 'minitest/mock'

OmniAuth.config.test_mode = true

Minitest.after_run do
  FileUtils.rm_rf(ActiveStorage::Blob.services.fetch(:test_fixtures).root)
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    class ActionDispatch::IntegrationTest
      def sign_in(user, _options = {})
        auth_hash = {
          provider: 'github',
          uid: '12345',
          info: {
            email: user.email,
            name: user.name
          }
        }

        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

        get callback_auth_url('github')
      end

      def signed_in?
        session[:user_id].present? && current_user.present?
      end

      def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
  end
end
