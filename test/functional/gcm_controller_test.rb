require 'test_helper'

class GcmControllerTest < ActionController::TestCase
  test "should get push" do
    get :push
    assert_response :success
  end

  test "should get post" do
    get :post
    assert_response :success
  end

  test "should get reg" do
    get :reg
    assert_response :success
  end

end
