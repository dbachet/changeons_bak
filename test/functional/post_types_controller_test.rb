# -*- encoding : utf-8 -*-
require 'test_helper'

class PostTypesControllerTest < ActionController::TestCase
  setup do
    @post_type = post_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_type" do
    assert_difference('PostType.count') do
      post :create, :post_type => @post_type.attributes
    end

    assert_redirected_to post_type_path(assigns(:post_type))
  end

  test "should show post_type" do
    get :show, :id => @post_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @post_type.to_param
    assert_response :success
  end

  test "should update post_type" do
    put :update, :id => @post_type.to_param, :post_type => @post_type.attributes
    assert_redirected_to post_type_path(assigns(:post_type))
  end

  test "should destroy post_type" do
    assert_difference('PostType.count', -1) do
      delete :destroy, :id => @post_type.to_param
    end

    assert_redirected_to post_types_path
  end
end
