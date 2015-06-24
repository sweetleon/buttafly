require 'test_helper'
  
  describe "Buttafly::Spreadsheet" do 

  subject { Buttafly::Spreadsheet }

  describe "db" do 

    specify "columns & types" do

      must_have_column(:data, :json)
      must_have_column(:name, :string)
      must_have_column(:user_id, :integer)
      must_have_column(:imported_at, :datetime)
      must_have_column(:aasm_state, :string)
      must_have_column(:source_row_count, :integer)
      must_have_column(:mtime, :integer)
    end

    specify "indexes" do 
    
      must_have_index(:aasm_state)
      must_have_index(:imported_at)
      must_have_index(:user_id)
      must_have_index(:name)
    end
  end
end
