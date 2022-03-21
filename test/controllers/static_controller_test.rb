require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get about_seth" do
    get static_about_seth_url
    assert_response :success
  end

  test "should get home" do
    get static_home_url
    assert_response :success
  end
end
