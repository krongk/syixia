require 'test_helper'

class TopItemsControllerTest < ActionController::TestCase
  setup do
    @top_item = top_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_item" do
    assert_difference('TopItem.count') do
      post :create, top_item: @top_item.attributes
    end

    assert_redirected_to top_item_path(assigns(:top_item))
  end

  test "should show top_item" do
    get :show, id: @top_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_item.to_param
    assert_response :success
  end

  test "should update top_item" do
    put :update, id: @top_item.to_param, top_item: @top_item.attributes
    assert_redirected_to top_item_path(assigns(:top_item))
  end

  test "should destroy top_item" do
    assert_difference('TopItem.count', -1) do
      delete :destroy, id: @top_item.to_param
    end

    assert_redirected_to top_items_path
  end
end
