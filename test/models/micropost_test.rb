require 'test_helper'

class MicropostTest < ActiveSupport::TestCase


  def setup

    @user = users(:michael)

    @micropost = @user.microposts.build(content: "Lorem ipsum")

  end

  test "Micropostが正常に保存されるか" do

    assert @micropost.valid?

  end

  test "ユーザidがMicropostに紐付いてなければエラーになるか" do

    @micropost.user_id = nil

    assert_not @micropost.valid?

  end

  test "内容が空白ではないか" do

    @micropost.content = " "

    assert_not @micropost.valid?

  end

  test "内容が140文字以内か" do

    @micropost.content = "a" * 141

    assert_not @micropost.valid?
  end

  test "最新の投稿が一番上に来る" do
    assert_equal microposts(:most_recent), Micropost.first

  end

end
