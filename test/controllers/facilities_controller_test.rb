require File.dirname(__FILE__) + '/../test_helper'

class FacilitiesControllerTest < ActionController::TestCase
  include SessionsHelper

  setup do
    @facility = facilities(:one)
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

  test "should create facility" do
    assert_difference('Facility.count', +1) do
      post :create, facility: { name: "MyString3", description: "MyText", capacity: 10, priority: true, min_capacity: 20, has_tv: true, has_projector: false, has_tables: true, has_chairs: true, has_sound:false, storage_location: "closet" }
    end

    assert_redirected_to facility_path(assigns(:facility))
  end

  test "should show facility" do
    get :show, id: @facility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility
    assert_response :success
  end

  test "should update facility" do
    patch :update, id: @facility, facility: { capacity: @facility.capacity, description: @facility.description, name: @facility.name }
    assert_response :redirect
  end

  test "should destroy facility" do
    assert_difference('Facility.count', -1) do
      delete :destroy, id: @facility
    end

    assert_redirected_to facilities_path
  end
end
