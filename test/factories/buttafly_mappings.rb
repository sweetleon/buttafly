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
            "rating"=>"reviewer rating",
            "content"=>"reviewer notes",
            "reviewer"=> {
              "name"=>"reviewer name"
            },
            "wine"=> {
              "name"=>"wine name",
              "vintage"=>"wine vintage",
              "winery"=> {
                "name"=>"winery name"
              }
            }
          }
        }
      }

      factory :mapping_without_parents do
        # targetable_model "Winery"
        legend { {
          "winery"=> {
            "name"=>"winery name"
          }
        }
      }
      end

      factory :mapping_with_parent do
        legend { {
          "wine"=> {
            "name"=>"wine name",
            "vintage"=>"wine vintage",
            "winery"=> {
              "name"=>"winery name"
            }
          }
        }
      }
      end

      factory :mapping_with_parents do
        targetable_model "Review"
      end
    end
  end
end
