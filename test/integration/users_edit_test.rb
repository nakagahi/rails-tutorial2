require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup

    @user = users(:michael)


  end

  test "ユーザアップデートの際のテスト(失敗時)" do

    log_in_as(@user)

    get edit_user_path(@user)

    assert_template 'users/edit'

    patch user_path(@user), params: {user: {
      name:  "",
                                                   email: "foo@invalid",
                                                   password:              "foo",
                                                   password_confirmation: "bar"
    }}

    assert_template 'users/edit'

    assert_select "div.alert", "The form contains 4 errors."

  end

  test "ユーザアップデートの際のテスト(成功時)" do

    post login_path, params: {session: {
      email: "michael@example.com",
      password: "password"
      }}

    get edit_user_path(@user)

    assert_template 'users/edit'

    patch user_path(@user), params: {user: {

      name: "中川 大樹",
      email: "iwbb1022@icloud.com",
      password: "",
      password_confirmation: ""
    }}
    #
    # follow_redirect!
    #
    # assert_template "users/show"
    #
    # assert_not flash.nil?
    #
    # user = User.find_by(name: "中川 大樹")
    #
    # assert_equal user.email, "iwbb1022@icloud.com"

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "中川 大樹"
    assert_equal @user.email, "iwbb1022@icloud.com"

  end

  test "フレンドリーフォワーディング" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    log_in_as(@user)
    assert_redirected_to user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                            email: email,
                                            password:              "",
                                            password_confirmation: "" } }
  assert_not flash.empty?
  assert_redirected_to @user
  @user.reload
  assert_equal name,  @user.name
  assert_equal email, @user.email
  end

end
