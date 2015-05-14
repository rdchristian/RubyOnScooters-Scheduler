require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  include SessionsHelper

  setup do
    @usert = users(:one)
    login @usert
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      temp = post :create, user: { name: "Jim", email: "jim@email.com", password_digest: "JimPass", remember_digest: "JimPass", phone: 1111111113, user_level: 2, activated: true }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @usert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usert
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @usert, user: { name: @usert.name }
    assert_response :redirect
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @usert
    end

    assert_redirected_to users_path
  end
end
