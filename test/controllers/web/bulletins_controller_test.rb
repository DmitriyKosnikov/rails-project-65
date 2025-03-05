require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
    @category = categories(:one)
    sign_in(@user)
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
end
