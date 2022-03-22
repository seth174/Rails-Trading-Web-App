require "test_helper"

class WithdrawsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get withdraws_new_url
    assert_response :success
  end
end
