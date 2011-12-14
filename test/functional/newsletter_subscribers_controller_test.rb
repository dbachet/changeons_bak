require 'test_helper'

class NewsletterSubscribersControllerTest < ActionController::TestCase
  setup do
    @newsletter_subscriber = newsletter_subscribers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsletter_subscribers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsletter_subscriber" do
    assert_difference('NewsletterSubscriber.count') do
      post :create, :newsletter_subscriber => @newsletter_subscriber.attributes
    end

    assert_redirected_to newsletter_subscriber_path(assigns(:newsletter_subscriber))
  end

  test "should show newsletter_subscriber" do
    get :show, :id => @newsletter_subscriber.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @newsletter_subscriber.to_param
    assert_response :success
  end

  test "should update newsletter_subscriber" do
    put :update, :id => @newsletter_subscriber.to_param, :newsletter_subscriber => @newsletter_subscriber.attributes
    assert_redirected_to newsletter_subscriber_path(assigns(:newsletter_subscriber))
  end

  test "should destroy newsletter_subscriber" do
    assert_difference('NewsletterSubscriber.count', -1) do
      delete :destroy, :id => @newsletter_subscriber.to_param
    end

    assert_redirected_to newsletter_subscribers_path
  end
end
