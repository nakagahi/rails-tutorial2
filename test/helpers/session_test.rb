require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  include SessionsHelper

  def setup
    @user = users(:michael)

    remember(@user)

  end

  test "crrent_usserが正常に動いているかどうか" do

    assert_equal @user, current_user
    assert loged_in?

  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

end
