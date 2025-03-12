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

  test 'PATCH reject transitions bulletin to rejected' do
    @reject_bulletin.to_moderate!
  end

  test 'PATCH publish transitions bulletin to published' do
    @publish_bulletin.to_moderate!
  end

  test 'PATCH archive bulletin to archived' do
    patch archive_admin
  end
end
