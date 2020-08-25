require 'test_helper'

class UserTest < ActiveSupport::TestCase


  def setup

    @user = User.new(name: "Example User", email: "user@example.com",
      password: "nh10221022", password_confirmation: "nh10221022")

  end

  test "should be valid" do

    assert @user.valid?

  end

  test "名前の存在性の確認" do

    @user.name = "  "

    assert_not @user.valid?

  end

  test "名前の長さの確認" do

    @user.name = "a" * 51

    assert_not @user.valid?

  end

  test "メールの存在性の確認" do

    @user.email = " "
    assert_not @user.valid?

  end

  test "メールの長さの確認" do
    @user.email = "b" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "テストフォーマットのテスト" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "メール一意性のテスト" do

    dump_user = @user.dup
    @user.save
    assert_not dump_user.valid?

  end

  test "メールのDB保存前小文字化のテスト" do

    email = "IWBB1022@iCould.Com"

    @user.email = email

    @user.save

    assert_equal @user.reload.email, email.downcase

  end

  test "パスワードが空白だとエラーを起こすテスト" do

    @user.password = @user.password_confirmation = " " * 6

    assert_not @user.valid?

  end

  test "パスワードの長さが最低6文字であることのテスト" do

    @user.password = @user.password_confirmation = "a" * 5

    assert_not @user.valid?
  end


end
