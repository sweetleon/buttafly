FactoryGirl.define do

  sequence :name do |n|
    "test_file_name#{n}"
  end

  factory :spreadsheet, :class => 'Buttafly::Spreadsheet' do
    name
    flat_file do 
      Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'test', 'samples', 'reviews.csv')) 
    end

    factory :uploaded_file do
      aasm_state "uploaded"

    end

    factory :targeted_file do 
      aasm_state "targeted"
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
