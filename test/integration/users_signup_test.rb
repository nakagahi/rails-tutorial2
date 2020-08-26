require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "ユーザ登録ボタンを押下時にエラーがあるとユーザが作成されないことのテスト" do

    get sign_up_path

    assert_no_difference 'User.count' do

      post users_path, params: {user: {
        name: "",
        email: "iwbb1022@icloud.com",
        password: "nh10221022",
        password_confirmation: "nh10221022"
        }}

    end

    assert_template 'users/new'
    assert_select "div.alert", "The form contains 1 error."
    assert_select "li.msg", "Name can't be blank"

  end

  test "ユーザ登録ボタンを押下時に正常だとユーザが作成され、プロフィールページが表示されるテスト" do

    get sign_up_path

    assert_difference 'User.count', 1 do

      post users_path, params: {user: {
        name: "中川 大樹",
        email: "iwbb1022@icloud.com",
        password: "nh10221022",
        password_confirmation: "nh10221022"
        }
      }

    end

    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert_select "div.alert-success", "Welcome to the Sample App!"

  end
end
