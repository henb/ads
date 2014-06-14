require 'test_helper'

class MyadsControllerTest < ActionController::TestCase
  setup do
    @myad = myads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:myads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create myad" do
    assert_difference('Myad.count') do
      post :create, myad: { description: @myad.description, title: @myad.title }
    end

    assert_redirected_to myad_path(assigns(:myad))
  end

  test "should show myad" do
    get :show, id: @myad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @myad
    assert_response :success
  end

  test "should update myad" do
    patch :update, id: @myad, myad: { description: @myad.description, title: @myad.title }
    assert_redirected_to myad_path(assigns(:myad))
  end

  test "should destroy myad" do
    assert_difference('Myad.count', -1) do
      delete :destroy, id: @myad
    end

    assert_redirected_to myads_path
  end
end
