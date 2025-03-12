# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @bulletin.image.attach(file_fixture_upload('test_image.jpg', 'image/jpg'))
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
    bulletin_mock = Minitest::Mock.new

    bulletin_mock.expect(:may_to_moderate?, true)

    bulletin_mock.expect(:to_moderate!, true)

    @controller.instance_variable_set(:@bulletin, bulletin_mock)

    patch to_moderate_bulletin_path(@bulletin)

    assert_redirected_to profile_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @bulletin.reload
    assert @bulletin.under_moderation?
  end

  test 'PATCH archive transitions bulletin to archived' do
    patch archive_bulletin_path(@bulletin)

    assert_redirected_to profile_path
    assert_equal flash[:notice], I18n.t('admin.messages.success')

    @bulletin.reload
    assert @bulletin.archived?
  end
end
