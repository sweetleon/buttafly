FactoryGirl.define do

  sequence :name do |n|
    "test_file_name#{n}"
  end
end