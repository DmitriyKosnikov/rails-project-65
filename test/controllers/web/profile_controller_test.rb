# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
  end
  test 'should get index' do
    get profile_url
    assert_response :success
  end
end
