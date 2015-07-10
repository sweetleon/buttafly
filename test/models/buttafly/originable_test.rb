require 'test_helper'
  
  describe "Buttafly::Originable" do 

  subject { Buttafly::Spreadsheet }

  describe "associations" do 

    specify "belongs to" do 
  
      must_belong_to(:user)
    end

    specify "has many" do 
  
      must_have_many(:legends)
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

      existing_sheet = FactoryGirl.create(:originable)
      new_sheet = FactoryGirl.build(:originable, name: existing_sheet.name)
      new_sheet.save
      refute new_sheet.valid?
    end
  end

  describe "states" do 

    specify "initial must be :uploaded" do 

      uploaded_file = subject.new
      uploaded_file.uploaded?.must_equal true
    end

    describe "permissions for" do 

      it ":uploaded" do
  
        file = build_stubbed(:uploaded_file)
        file.may_target?.must_equal true
        file.may_map?.must_equal false
        file.may_transmogrify?.must_equal false
      end

      it ":targeted" do 
  
        file = build_stubbed(:targeted_file)
        file.may_map?.must_equal true
        file.may_transmogrify?.must_equal false
      end

      it ":targeted" do 

        file = create(:mapped_file)
        file.may_transmogrify?.must_equal true
      end
    end

    describe "events" do

      describe "#transmogrify!" do

        let(:file) { FactoryGirl.create(:originable) }
        
        describe ":create_records" do           

          it "without parents" do
            skip
            file.mappings.create(FactoryGirl.attributes_for(:mapping_without_parents))
            file.create_records!
            Winery.count.must_equal 5
          end

          it "with one parent" do
skip
            file.mappings.create(FactoryGirl.attributes_for(:mapping_with_parent))
            file.create_records!
            # Winery.count.must_equal 5
            Wine.count.must_equal 5
          end

        end

        describe "must create" do 

          it "target objects" do 
            skip
            file.transmogrify!
            Review.count.must_equal 1
          end

          it "parent_objects" do
          end
        end
      end

      describe "#import!" do 

        let(:file) { create(:uploaded_file) }
      
        it "#convert_data_to_json!" do
skip
          file.convert_data_to_json!
          file.data.first["child name"].must_equal "ella mac"
          file.data.first["parent name"].must_equal "sara"
          file.data.first["grandparent name"].must_equal "kc shekhar"        
        end

        it "must populate data column with json" do 
skip
          file.import!
          file.data.first.wont_equal nil
          file.data.size.must_equal 2 
          file.aasm_state.must_equal "imported"
        end
      end
    end
  end
end
