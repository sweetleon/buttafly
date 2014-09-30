# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :name do |n|
    "test_file_name#{n}"
  end

  factory :spreadsheet, :class => 'Buttafly::Spreadsheet' do
    name
    flat_file do 
      Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'test', 'samples', 'family.odt.csv')) 
    end
    data [
      {"mother"=>"Sarah Jane Schoeneman", 
        "child"=>"Ella Mac Pacurar", 
        "grandparent"=>"Vicki Pacurar"
      }]

    factory :not_imported_file do
      aasm_state "not_imported"
      data {{}}

      factory :originable
    end

    factory :imported_file do 
      aasm_state "imported"
    end

    factory :published_file do 
      aasm_state "published"
    end

    factory :unpublished_file do 
      aasm_state "unpublished"
    end
  end
end
