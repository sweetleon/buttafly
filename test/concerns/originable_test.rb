require 'test_helper'

  describe "Buttafly::Originable" do

  subject { Buttafly::Spreadsheet }

  let(:spreadsheet) { FactoryGirl.create(:originable) }

  describe "associations" do

    specify "has many" do

      must_have_many(:mappings)
    end
  end

  describe "validations" do

    specify "presence of flat_file" do

      sheet = subject.new(flat_file: nil)
      sheet.save
      sheet.valid?.wont_equal true
    end

    specify "uniqueness of flat_file and name" do

      existing_sheet = spreadsheet
      new_sheet = FactoryGirl.build(:originable, name: existing_sheet.name)
      new_sheet.save
      refute new_sheet.valid?
    end
  end

  it "must return true for originable models" do
    subject.originable?.must_equal true
  end

  it "self.targetable_models" do

    actual = spreadsheet.targetable_models
    expected = ["DummyChild", "DummyGrandparent", "DummyParent", "DummyTribe",
                "Review", "User", "Wine", "Winery"]
    assert_equal actual, expected
  end

  it "#originable_headers must return correct headers" do
    actual = spreadsheet.originable_headers
    expected = ["wine name", "winery name", "wine vintage", "reviewer notes", "reviewer rating"]
    (actual & expected).must_equal expected
  end

  it "tsorted_order" do
    spreadsheet.tsorted_order
  end

  it "self.targetable_parents" do
    spreadsheet.targetable_parents(:winery).must_equal []
    spreadsheet.targetable_parents(:user).must_equal []
    spreadsheet.targetable_parents(:wine).must_equal [:winery]
    spreadsheet.targetable_parents(:review).must_equal [:user, :wine]
  end

  it "ancestors_of(klass)" do
    spreadsheet.ancestors_of(:winery).must_equal nil
    spreadsheet.ancestors_of(:user).must_equal nil
    spreadsheet.ancestors_of(:wine).must_equal [:winery]
    spreadsheet.parents_of(:review).must_equal [:user, :wine]
  end

  it "parents_of(model)" do
    spreadsheet.parents_of(:winery).must_equal []
    spreadsheet.parents_of(:user).must_equal []
    spreadsheet.parents_of(:wine).must_equal [:winery]
    spreadsheet.parents_of(:review).must_equal [:user, :wine]
  end

  it "tsorted_order" do

    actual = spreadsheet.tsorted_order
    actual.class.must_equal TsortableHash
    actual.keys.must_equal [:dummy_child, :dummy_grandparent, :dummy_parent, :dummy_tribe, :review, :user, :wine, :winery]
    actual[:dummy_child].must_equal [:dummy_parent, :dummy_tribe]
    actual[:dummy_grandparent].must_equal [:dummy_tribe]
    actual[:dummy_parent].must_equal [:dummy_grandparent, :dummy_tribe]
    actual[:dummy_tribe].must_equal []
    actual[:review].must_equal [:user, :wine]
    actual[:wine].must_equal [:winery]
    actual[:winery].must_equal []
    actual[:user].must_equal []
  end

  describe "states" do

    specify "initial must be :uploaded" do

      uploaded_file = subject.new
      uploaded_file.uploaded?.must_equal true
    end

    describe "permissions for" do

      it ":uploaded" do

        file = build_stubbed(:uploaded_file)
        file.may_map?.must_equal true
        file.may_transmogrify?.must_equal false
      end
    end

    describe "events" do

      describe "#transmogrify!" do

        let(:file) { FactoryGirl.create(:originable) }

        describe ":create_records" do

          before :each do
            Winery.delete_all
            Wine.delete_all
            Review.delete_all
            User.delete_all
          end

          it "without parents" do

            attrs = FactoryGirl.attributes_for(:mapping_without_parents)

            file.mappings.create(attrs)
            file.create_records!
            assert Winery.count.must_equal 5
            assert Winery.find_by(name: "Ernest & Hulio Gallows")
          end

          it "with one parent" do

            attrs = FactoryGirl.attributes_for(:mapping_with_parent)

            file.mappings.create(attrs)
            file.create_records!
            Winery.count.must_equal 5
            Wine.count.must_equal 5
          end

          it "with more than one parents" do

            attrs = FactoryGirl.attributes_for(:mapping_with_parents)

            file.mappings.create(attrs)
            file.create_records!
            Winery.count.must_equal 5
            Wine.count.must_equal 5
            Review.count.must_equal 5
            User.count.must_equal 3

            review = Review.where(content: "Big and strong nevertheless soggy charbono. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never.").first
            wine = review.wine
            winery = review.wine.winery
            reviewer = review.reviewer

            review.reviewer.name.must_equal "stephen tanzer"
            review.wine.name.must_equal "Pinot Noir Solera"
            wine.winery.name.must_equal "Sunnybrook Estate"
            review.wine.winery.name.must_equal "Sunnybrook Estate"
          end
        end
      end

      describe "#import!" do

        let(:file) { create(:uploaded_file) }

#         it "#convert_data_to_json!" do
#           file.convert_data_to_json!
#           file.data.first["child name"].must_equal "ella mac"
#           file.data.first["parent name"].must_equal "sara"
#           file.data.first["grandparent name"].must_equal "kc shekhar"
#         end

#         it "must populate data column with json" do
#           file.import!
#           file.data.first.wont_equal nil
#           file.data.size.must_equal 2
#           file.aasm_state.must_equal "imported"
#         end
      end
    end
  end
end