require File.dirname(__FILE__) + '/../test_helper'

class ResourcesControllerTest < ActionController::TestCase
  include SessionsHelper

  setup do
    @resource = resources(:one)
    @user = users(:one)
    login @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource" do
    assert_difference('Resource.count', +1) do
      post :create, resource: { description: @resource.description, name: "Test 3", 
                                numberOf: @resource.numberOf, storage_location: @resource.storage_location,
                                max_reserve_time: @resource.max_reserve_time }
    end

    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should show resource" do
    get :show, id: @resource
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resource
    assert_response :success
  end

  test "should update resource" do
    patch :update, id: @resource, resource: { description: @resource.description, name: @resource.name,
                                               numberOf: @resource.numberOf, storage_location: @resource.storage_location,
                                               max_reserve_time: @resource.max_reserve_time }
    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @resource
    end

    assert_redirected_to resources_path
  end
end
