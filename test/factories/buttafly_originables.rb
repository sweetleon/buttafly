FactoryGirl.define do

  factory :originable, class: 'Buttafly::Spreadsheet' do
    name
    aasm_state "uploaded"
    flat_file do
      Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'test', 'samples', 'reviews.csv'))
    end

    factory :uploaded_file do

      aasm_state "uploaded"
    end

    factory :mapped_file do

      after(:create) do |originable|
        create(:mapping_with_legend, originable: originable)
      end
    end
  end
end
