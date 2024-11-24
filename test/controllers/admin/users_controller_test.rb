require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_users_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_users_update_url
    assert_response :success
  end
end
