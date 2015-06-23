# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    targetable_model "Review"
    association :originable

    factory :mapping_with_data do

      legend_data {
        [
          ["wine", "wine::name"], 
          ["winery", "winery::name"], 
          ["vintage", "wine::vintage"], 
          ["review", "content"], 
          ["rating", "rating"]
        ]
      }
    end
  end
end
