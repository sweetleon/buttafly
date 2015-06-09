# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mapping, :class => 'Buttafly::Mapping' do

    targetable_model "Review"
    originable

    factory :mapping_with_data do

      data do 
        { 
          review: { 
            rating: 94,
            content: "blah",
            reviewer: {
              name: "Robert Parker"
            },
            wine: {
              name: "Oppenlander Nebbiolo",
              vintage: 2000,
              winery: {
                name: "Ernie & Julio Gallows"
              }
            } 
          } 
        }
      end

    end


    factory :mapping_with_legend do
      legend 
    end
  end
end
