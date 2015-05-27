require "test_helper"

class WineryTest < ActiveSupport::TestCase

  def winery
    @winery ||= Winery.new
  end

  def test_valid
    assert winery.valid?
  end

end
