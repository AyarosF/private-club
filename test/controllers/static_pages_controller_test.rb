require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  def setup
    @user = users(:one)
  end

  test 'should display navbar selectors' do
    get 'users/:id'
    assert_response :success
    if logged_in?
      assert_select 'a[href=?]', '/users/:id/edit', text: 'Editer'
      assert_select 'a[href=?]', '/logout', text: 'Se déconnecter'
    else
      assert_select 'a[href=?]', '/login', text: 'Se connecter'
      assert_select 'a[href=?]', '/users/new', text: "S'inscrire"
    end
  end

  test 'should display body links' do
    get root_url
    assert_response :success
    if logged_in?
      assert_select 'p' do
        assert_select 'a[href=?]', '/private', text: 'Accédez ici à votre espace privé.'
      end
    else
      assert_select 'p' do
        assert_select 'a[href=?]', '/login', text: 'Connectez-vous'
        assert_select 'a[href=?]', '/users/new', text: 'inscrivez-vous'
      end
    end
  end
end
