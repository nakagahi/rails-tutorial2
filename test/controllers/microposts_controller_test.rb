require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  # Micropostコントローラー内のアクセス制御
  # 関連付けれらたユーザを通してマイクロソフトにアクセスする
  #⇒ユーザはログイン状態じゃないといけない
  # 正しいリクエストを書くアクションに向けて発行しマイクロソフトの数が変化してないかどうか

  def setup
    @micropost = microposts(:orange)
  end

  test "ログインされていない状態でcreateアクションを呼び出されるとリダイレクトする" do

    assert_no_difference "Micropost.count" do

      post microposts_path, params: {micropost: {content: "Lorem ipusum"}}

    end

    assert_redirected_to login_path
  end

  test "ログインされていない状態でdestroyアクションを呼び出されるとリダイレクトする" do

    assert_no_difference "Micropost.count" do

      delete micropost_path(@micropost)
    end

    assert_redirected_to login_path
  end


end
