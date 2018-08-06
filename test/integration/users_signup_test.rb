require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # tester la page d'inscription, qui doit retourner une erreur si la personne n'a pas rentré les bons champs 
  test 'invalid signup information' do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  '',
                                         last_name: '',
                                         email: 'user@invalid',
                                         password:              'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div', attributes: { id: 'error_explanation' }
    assert_select 'div.alert-danger'
  end
end
