require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  test "should get running" do
    get :running
    assert_response :success
  end

  test "should get last_run" do
    get :last_run
    assert_response :success
  end

end
