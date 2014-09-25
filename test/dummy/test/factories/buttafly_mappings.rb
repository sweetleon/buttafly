# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    legend
    targetable
    originable


  end
end
