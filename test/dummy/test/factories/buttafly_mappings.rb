# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    targetable_model "DummyChild"
    originable

    factory :mapping_with_legend do
      legend 
    end
  end
end
