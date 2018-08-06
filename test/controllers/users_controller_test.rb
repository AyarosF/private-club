require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get private page' do
    if log_in_as(@user)
      get index_url
      assert_response :success

    else
      get login_url
      assert_response :success
    end
  end

  # test 'should create user' do
  #   assert_difference('User.count') do
  #     post users_url, params: { user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password } }
  #   end
  #
  #   assert_redirected_to user_url(User.last)
  # end
end
