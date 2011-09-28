require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get top" do
    get :top
    assert_response :success
  end

  test "should get share" do
    get :share
    assert_response :success
  end

end
