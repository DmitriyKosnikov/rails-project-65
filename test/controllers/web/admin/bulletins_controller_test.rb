require "test_helper"

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in(@user)
  end

  test "should get index" do
    get admin_bulletins_url
    assert_response :success
  end

  # test "should get moderation" do
  #   get web_admin_bulletins_moderation_url
  #   assert_response :success
  # end
end
