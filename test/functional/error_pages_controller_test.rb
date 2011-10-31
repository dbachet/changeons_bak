require 'test_helper'

class ErrorPagesControllerTest < ActionController::TestCase
  test "should get javascript_disabled" do
    get :javascript_disabled
    assert_response :success
  end

end
