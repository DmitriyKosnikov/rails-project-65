# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    @category = categories(:one)
    sign_in(@user)
  end

  test 'should get index' do
    get admin_categories_path

    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_path

    assert_response :success
  end

  test 'should get create' do
    post admin_categories_url, params: {
      name: @category.name
    }

    created_category = Category.find_by(
      name: @category.name
    )

    assert(created_category)
  end

  test 'should get edit' do
    get edit_admin_category_path(@category)

    assert_response :success
  end

  test 'should get update' do
    patch admin_category_path(@category), params: {
      name: @category.name
    }

    updated_category = Category.find_by(
      name: @category.name
    )

    assert(updated_category)
  end

  test 'should destroy' do
    delete admin_category_path(@category)

    assert_redirected_to admin_categories_path
    assert flash[:notice] == I18n.t('category.actions.destroy_has_bulletins')
  end
end
