# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dummy_child do

    name "Ella Mac"
    dummy_parent
    dummy_tribe

    factory :targetable
  end
end
