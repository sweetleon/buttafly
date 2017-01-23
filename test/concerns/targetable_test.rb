require 'test_helper'

describe "Buttafly::Targetable" do

  subject { Review }

  describe "class methods" do

    it "must return true for :targetable?" do
      subject.targetable?.must_equal true
    end

    it "#self.targetable_ignored_columns" do
      assert_equal %w[updated_at created_at id], subject.targetable_ignored_columns
    end

    it "#self.targetable_columns" do
      expected = %w(content rating reviewer_id wine_id)
      actual = subject.targetable_columns
      assert_equal expected, (expected & actual)
    end

    it "#self.targetable_attrs()" do
      assert subject.respond_to? :targetable_attrs
      assert_equal %w[rating content], subject.targetable_attrs
      refute_equal %[id reviewer_id wine_id], subject.targetable_attrs
    end
  end
end
