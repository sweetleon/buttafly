# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :name do |n|
    "test_file_name#{n}"
  end

  factory :spreadsheet, :class => 'Buttafly::Spreadsheet' do
    name
    flat_file do 
      Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'test', 'samples', 'review.odt.csv')) 
    end

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

    # factory :processed_file do
    #   aasm_state "processed"
    # end

    # factory :removed_file do
    #   aasm_state "removed"
    # end

    # factory :ignored_file do
    #   aasm_state "ignored"
    # end

    # factory :modified_file do
    #   aasm_state "modified"
    # file_name "#{@name}"
    # end

# end
