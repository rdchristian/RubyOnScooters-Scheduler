require File.dirname(__FILE__) + '/../test_helper'

class AlertsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
