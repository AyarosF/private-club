require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
  end

  # si une personne non login essaie d'aller sur une page edit, le site va la rediriger vers la page de login en lui disant de se login pour aller à ce contenu
  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # si une personne login essaie de modifier un profil autre que le sien, le site va la rediriger vers la page d'accueil en lui disant que l'accés est restreint
  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              email: @user.email } }
    assert_redirected_to root_url
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  # Si une personne non login essaie d'aller sur une page show, le site va la rediriger vers la page de login en lui disant de se login pour aller à ce contenu
  test 'should access users profiles if logged' do
    if log_in_as(@user)
      get user_path(@user.id)
      assert_response :success
    else
      assert_template 'sessions/new'
      get login_path
      assert_not flash.empty?
    end
  end

  # La page de show doit afficher les informations de l'utilisateur
  test 'should show user info' do
    if log_in_as(@user)
      get user_url(@user)
      assert_response :success
      assert_select 'td', @user.first_name
      assert_select 'td', @user.last_name
      assert_select 'td', @user.email
    else
      get login_url
      assert_response :success
    end
  end

  # tester la page du club, qui ne doit être accessible qu'aux personnes login
  test 'should access private page if logged' do
    if log_in_as(@user)
      get index_url
      assert_response :success
    else
      get login_url
      assert_response :success
      assert_not flash.empty?
    end
  end

  # La page doit renvoyer la liste des personnes inscrites au site
  test 'should show users profile on private page' do
    if log_in_as(@user)
      get users_url
      assert_select 'td', @user.first_name
      assert_select 'td', @user.last_name
      assert_select 'td', @user.email
    else
      get login_url
      assert_response :success
    end
  end
end
