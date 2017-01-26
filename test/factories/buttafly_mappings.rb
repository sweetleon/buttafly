FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

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
                "name"=>"winery name" } } } }
      end

      factory :mapping_with_parents do
      end
    end
  end
end
