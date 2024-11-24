require "test_helper"

class Admin::UserWalletsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_user_wallets_update_url
    assert_response :success
  end
end
