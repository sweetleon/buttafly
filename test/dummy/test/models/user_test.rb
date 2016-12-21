require "test_helper"

describe User do

  def user
    @user ||= User.new
  end

  def test_valid
    assert user.valid?
  end

end
