require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  def setup
    @user = users(:one)
  end

  test 'should display navbar selectors' do
    get user_url(@user)
    assert_response :success
    if logged_in?
      assert_select 'li', '/users/:id/edit', text: 'Editer'
      assert_select 'li', '/logout', text: 'Se déconnecter'
    else
      assert_select 'li', '/login', text: 'Se connecter'
      assert_select 'li', '/users/new', text: "S'inscrire"
    end
  end

  test 'should display body links' do
    get root_url
    assert_response :success
    if logged_in?
      assert_select 'p' do
        assert_select 'li', '/users', text: 'Page privée'
      end
    else
      assert_select 'p' do
        assert_select 'li', '/login', text: 'Se connecter'
        assert_select 'li', '/users/new', text: "S'inscrire"
      end
    end
  end
end
