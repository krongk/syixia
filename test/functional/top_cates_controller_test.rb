require 'test_helper'

class TopCatesControllerTest < ActionController::TestCase
  setup do
    @top_cate = top_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_cate" do
    assert_difference('TopCate.count') do
      post :create, top_cate: @top_cate.attributes
    end

    assert_redirected_to top_cate_path(assigns(:top_cate))
  end

  test "should show top_cate" do
    get :show, id: @top_cate.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_cate.to_param
    assert_response :success
  end

  test "should update top_cate" do
    put :update, id: @top_cate.to_param, top_cate: @top_cate.attributes
    assert_redirected_to top_cate_path(assigns(:top_cate))
  end

  test "should destroy top_cate" do
    assert_difference('TopCate.count', -1) do
      delete :destroy, id: @top_cate.to_param
    end

    assert_redirected_to top_cates_path
  end
end
