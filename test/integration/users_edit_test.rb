require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 def setup
    @user = users(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                           last_name: "garcia",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

   test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name  = "Soraya"
    last_name = "Fructuoso"
    email = "sfructuoso@gmail.com"
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal last_name,  @user.last_name
    assert_equal email, @user.email
  end





end
