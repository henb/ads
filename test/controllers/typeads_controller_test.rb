require 'test_helper'

class TypeadsControllerTest < ActionController::TestCase
  setup do
    @typead = typeads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typeads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typead" do
    assert_difference('Typead.count') do
      post :create, typead: { name: @typead.name, text: @typead.text }
    end

    assert_redirected_to typead_path(assigns(:typead))
  end

  test "should show typead" do
    get :show, id: @typead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @typead
    assert_response :success
  end

  test "should update typead" do
    patch :update, id: @typead, typead: { name: @typead.name, text: @typead.text }
    assert_redirected_to typead_path(assigns(:typead))
  end

  test "should destroy typead" do
    assert_difference('Typead.count', -1) do
      delete :destroy, id: @typead
    end

    assert_redirected_to typeads_path
  end
end
