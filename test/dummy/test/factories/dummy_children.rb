# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dummy_child do

    child_name "Ella Mac"
    dummy_parent

    factory :targetable
  end
end