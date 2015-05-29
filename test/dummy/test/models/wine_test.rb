require "test_helper"

class WineTest < ActiveSupport::TestCase

  def wine
    @wine ||= Wine.new
  end

  def test_valid
    assert wine.valid?
  end

end
