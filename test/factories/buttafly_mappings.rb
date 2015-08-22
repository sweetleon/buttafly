# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    targetable_model "Review"
    association :originable

    factory :mapping_without_legend do
    end

    factory :mapping_with_empty_legend do
      legend {{}}
    end

    factory :mapping_with_legend do

      legend { {

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
        legend { {
          "winery"=> {
            "name"=>"winery", 
            "mission"=>"wine", 
            "history"=>"wine"
          }
        }
      }
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
