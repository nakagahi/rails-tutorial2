require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    # usersはfixtureのファイル名users.ymlを表している
  end

  test "ログイン時のフラッシュのテスト" do

    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {
      name: @user.name,
      email: "invalid",
      }}

      assert_not logged_in?

      assert_redirected_to root_path

      assert_not flash.empty?

  end

  test "ログイン成功時のテスト" do
    get login_path

    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }

    assert logged_in?


    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    delete logout_path

    assert_not logged_in?
    assert_redirected_to root_path


    delete logout_path #２つ目のウィンドウでログアウト
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", sign_up_path


  end

  test "クッキーの暴走" do

    assert_not @user.authenticated?(:remember, "")

  end

  test "ログインしてログアウトした時のcookiesの値" do

    log_in_as(@user)
    assert_not_empty cookies[:remember_token]
    delete logout_path
    assert_empty cookies[:remember_token]

    log_in_as(@user, remember_me: "0")
    assert_empty cookies[:remember_token]

  end

end
