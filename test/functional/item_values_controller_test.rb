require 'test_helper'

class ItemValuesControllerTest < ActionController::TestCase
  setup do
    @item_value = item_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_value" do
    assert_difference('ItemValue.count') do
      post :create, item_value: @item_value.attributes
    end

    assert_redirected_to item_value_path(assigns(:item_value))
  end

  test "should show item_value" do
    get :show, id: @item_value.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_value.to_param
    assert_response :success
  end

  test "should update item_value" do
    put :update, id: @item_value.to_param, item_value: @item_value.attributes
    assert_redirected_to item_value_path(assigns(:item_value))
  end

  test "should destroy item_value" do
    assert_difference('ItemValue.count', -1) do
      delete :destroy, id: @item_value.to_param
    end

    assert_redirected_to item_values_path
  end
end
