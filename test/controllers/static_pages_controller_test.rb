require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  def setup
    @user = users(:one)
  end

  # tester la page d'accueil : faire en sorte qu'elle affiche les bons liens, en fonction si la personne est connectée ou non
  test 'show links' do
    get root_url
    assert_response :success
    if logged_in?
      assert_select 'p' do
        assert_select 'a[href=?]', '/users', text: 'Clique ici pour accéder à la page privée'
      end
    else
      assert_select 'p' do
        assert_select 'a[href=?]', '/login', text: 'Connecte-toi ici'
        assert_select 'a[href=?]', '/users/new', text: 'Inscris-toi ici'
      end
    end
  end

  # tester la navbar, qui doit afficher les bons liens
  test 'show navbar links' do
    get root_url
    assert_response :success
    if logged_in?
      # Le lien de show doit être accessible de la navbar pour toute personne qui est login
      assert_select 'a[href=?]', '/users/:id', text: 'Ton compte'
      assert_select 'a[href=?]', '/users/:id', text: 'Profil'
      assert_select 'a[href=?]', '/logout', text: 'Se déconnecter'
    else
      assert_select 'a[href=?]', '/login', text: 'Se connecter'
      assert_select 'a[href=?]', '/users/new', text: "S'inscrire"
    end
  end
end
