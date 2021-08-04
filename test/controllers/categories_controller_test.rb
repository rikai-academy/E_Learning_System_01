require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get categories_home_url
    assert_response :success
  end
end
