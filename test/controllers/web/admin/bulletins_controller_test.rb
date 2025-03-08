# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  include AASM
  setup do
    @user = users(:admin)
    @publish_bulletin = bulletins(:publish)
    @reject_bulletin = bulletins(:reject)
    @archive_bulletin = bulletins(:archive)
    sign_in(@user)
  end

  test 'should get index' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'should get moderation' do
    get admin_url
    assert_response :success
  end
end
