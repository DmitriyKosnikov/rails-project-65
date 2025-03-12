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
    @reject_bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )

    @reject_bulletin.save

    patch reject_admin_bulletin_path(@reject_bulletin)

    assert_redirected_to admin_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @reject_bulletin.reload
    assert @reject_bulletin.rejected?
  end

  test 'PATCH publish transitions bulletin to published' do
    @publish_bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )

    @publish_bulletin.save

    patch publish_admin_bulletin_path(@publish_bulletin)

    assert_redirected_to admin_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @publish_bulletin.reload
    assert @publish_bulletin.published?
  end

  test 'PATCH archive bulletin to archived' do
    @archive_bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )

    @archive_bulletin.save

    patch archive_admin_bulletin_path(@archive_bulletin)

    assert_redirected_to admin_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @archive_bulletin.reload
    assert @archive_bulletin.archived?
  end
end
