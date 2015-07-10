# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    targetable_model "Review"
    association :originable

    factory :mapping_without_legend_data do
    end


    factory :mapping_with_data do

      legend_data { {

          "review"=> {
            "rating"=>"rating",
            "content"=>"review",
            "user"=> {
              "name"=>"wine"
            },
            "wine"=> {
              "name"=>"wine",
              "vintage"=>"vintage",
              "winery"=> {
                "name"=>"winery", 
                "mission"=>"wine", 
                "history"=>"wine"
              }
            }
          }
        }
      }

      factory :mapping_without_parents do
        targetable_model "Winery"
      end
      
      factory :mapping_with_parent do
        targetable_model "Wine"
      end

      factory :mapping_with_parents do
        targetable_model "Review"
      end
    end
  end
end
