# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @state_bulletin = bulletins(:two)
    @user = users(:one)
    @category = categories(:one)
    sign_in(@user)
  end

  test 'should get index' do
    get root_url

    assert_response :success
  end

  test 'should get edit bulletin' do
    get edit_bulletin_url(@bulletin)

    assert_response :success
  end

  test 'should create bulletin' do
    post bulletins_url, params: {
      bulletin: {
        title: @bulletin.title,
        description: @bulletin.description,
        category_id: @category.id,
        image: file_fixture_upload('test_image.jpg', 'image/jpg')
      }
    }

    assert_response :redirect

    created_bulletin = Bulletin.find_by(
      title: @bulletin.title,
      description: @bulletin.description,
      category_id: @category.id
    )

    assert(created_bulletin)
  end

  test 'should update bulletin' do
    patch bulletin_url(@bulletin), params: {
      bulletin: {
        title: @bulletin.title,
        description: @bulletin.description,
        category_id: @category.id,
        image: file_fixture_upload('test_image.jpg', 'image/jpg')
      }
    }

    assert_response :redirect

    updated_bulletin = Bulletin.find_by(
      title: @bulletin.title,
      description: @bulletin.description,
      category_id: @category.id
    )

    assert(updated_bulletin)
  end

  test 'PATCH to_moderate transitions bulletin to under_moderation' do
    @state_bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )

    @state_bulletin.save

    patch to_moderate_bulletin_path(@state_bulletin)

    assert_redirected_to profile_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @state_bulletin.reload
    assert @state_bulletin.under_moderation?
  end

  test 'PATCH archive transitions bulletin to archived' do
    @state_bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )

    @state_bulletin.save

    patch archive_bulletin_path(@state_bulletin)

    assert_redirected_to profile_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @state_bulletin.reload
    assert @state_bulletin.archived?
  end
end
