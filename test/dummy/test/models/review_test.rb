require 'test_helper'

describe "Buttafly::Targetable" do

  targetable_models = %w[review wine]

  targetable_models.each do |tm|

    subject { tm.classify.constantize }

    describe "class methods" do

      it "must return true for :targetable?" do
        subject.targetable?.must_equal true
      end

      it "#self.targetable_ignored_columns" do
        assert_equal %w[updated_at created_at id], subject.targetable_ignored_columns
      end

      it "#self.targetable_columns" do
        columns = subject.column_names
        (columns + subject.targetable_columns).uniq.must_equal columns
      end

      it "#self.targetable_attrs()" do
        assert subject.respond_to? :targetable_attrs
        case tm
        when "review"
          subject = tm.classify.constantize

          assert_equal %w[rating content], subject.targetable_attrs
          refute_equal %[id reviewer_id wine_id], subject.targetable_attrs
        when "wine"
          subject = tm.classify.constantize
          assert_equal %w[name vintage], subject.targetable_attrs
          refute_equal %[winery_id name], subject.targetable_attrs

        end
      end
    end
  end
end