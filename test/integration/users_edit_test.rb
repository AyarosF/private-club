require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
   end

  # le formulaire edit doit renvoyer une erreur si un personne ne passe pas les bons paramètres

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  '',
                                              last_name: 'Fructuoso',
                                              email: 'foo@invalid' } }
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name = 'Soraya'
    last_name = 'Fructuoso'
    email = 'sfructuoso@gmail.com'
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              email: email } }
    assert flash.empty?
    get user_url(@user)
    @user.reload
    assert_equal first_name, @user.first_name
    assert_equal last_name, @user.last_name
    assert_equal email, @user.email
  end
end
