require File.dirname(__FILE__) + '/../test_helper'

class EventsControllerTest < ActionController::TestCase
  include SessionsHelper
  setup do
    @event = events(:one)
    @user = users(:one)
    login @user
  end

  test "should get index" do
    get :index, user_id: @user
    assert_response :success
  end

  test "should get new" do
    get :new, user_id: @user
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { description: @event.description, ending: @event.ending, start: @event.start, title: @event.title, user_id: 2, recurrence: "Recur1", resource_counts: "Count1", approved: true, checked_in: true, attendees: 5, memo: "Memo1", picture: "Pic1", recur_until: "2015-04-02 17:37:12"  }, user_id: @user.id
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get(:show, {id: @event.id}, {user_id: @user.id})
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { description: @event.description, ending: @event.ending, start: @event.start, title: @event.title }
    assert_response :redirect
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy
    end

    assert_redirected_to events_path
  end
end
