require "test_helper"

class StocksSoldPerPeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stocks_sold_per_people_new_url
    assert_response :success
  end

  test "should get index" do
    get stocks_sold_per_people_index_url
    assert_response :success
  end
end
