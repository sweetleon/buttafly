# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dummy_parent do

    name "Sarah Jane Schoeneman"
    dummy_grandparent
    dummy_tribe
  end
end
