require "test_helper"

class StocksPurchasedPerPeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stocks_purchased_per_people_new_url
    assert_response :success
  end
end
