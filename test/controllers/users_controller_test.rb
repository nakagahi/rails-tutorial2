require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other = users(:archer)
  end

  test "should get new" do
    get sign_up_url
    assert_response :success
  end

  test "ログインしていないときに編集画面に行くとログインにリダイレクトされる" do

    get edit_user_path(@user)

    assert_not flash.empty?

    assert_redirected_to login_path

  end

  test "ログインしていないときに更新しようとするとログインにリダイレクトされる" do

    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }

    assert_not flash.empty?

    assert_redirected_to login_path

  end

  test "ログインした後、他のユーザを編集しようとするとホームページにリダイレクトされる" do

    log_in_as(@user)

    get edit_user_path(@other)

    assert_not flash.empty?

    assert_redirected_to root_path


  end

  test "ログインした後、他のユーザを更新しようとするとホームページにリダイレクトされる" do

    log_in_as(@user)

    patch user_path(@other), params: {user: {
      email: "",
      password: ""
      }}

    assert_not flash.empty?

    assert_redirected_to root_path

  end

  test "ユーザ一覧アクションのテスト" do
    log_in_as(@user)
    get users_path
    assert_template "users/index"


  end

  test "ユーザ削除(ログイン無し)のテスト" do

    assert_no_difference 'User.count' do

      delete user_path(@user)

      assert_redirected_to login_path

    end

  end

  test "ユーザ削除(ログインありで失敗)のテスト" do

    log_in_as(@other)

    assert_no_difference 'User.count' do

      delete user_path(@user)

    end

    assert_redirected_to users_path

  end

  test "ユーザ削除(成功)のテスト" do

    log_in_as(@user)

    assert_difference 'User.count', -1 do

      delete user_path(@other)

    end

    assert_redirected_to users_path

  end

end
