require "test_helper"

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    @category = categories(:one)
  end
  test "should get create" do
    post admin_categories_url, params: {
      name: @category.name
    }

    assert_response :redirect

    created_category = Category.find_by(
      name: @category.name
    )

    assert(created_category)
  end

  test "should get update" do
    patch admin_category_path(@category), params: {
      name: @category.name
    }

    assert_response :redirect

    updated_category = Category.find_by(
      name: @category.name
    )

    assert(updated_category)
  end
end
