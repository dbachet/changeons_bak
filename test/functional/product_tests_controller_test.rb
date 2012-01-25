require 'test_helper'

class ProductTestsControllerTest < ActionController::TestCase
  setup do
    @product_test = product_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_test" do
    assert_difference('ProductTest.count') do
      post :create, :product_test => @product_test.attributes
    end

    assert_redirected_to product_test_path(assigns(:product_test))
  end

  test "should show product_test" do
    get :show, :id => @product_test.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_test.to_param
    assert_response :success
  end

  test "should update product_test" do
    put :update, :id => @product_test.to_param, :product_test => @product_test.attributes
    assert_redirected_to product_test_path(assigns(:product_test))
  end

  test "should destroy product_test" do
    assert_difference('ProductTest.count', -1) do
      delete :destroy, :id => @product_test.to_param
    end

    assert_redirected_to product_tests_path
  end
end
