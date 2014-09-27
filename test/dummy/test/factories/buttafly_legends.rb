# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :legend, :class => 'Buttafly::Legend' do

    data { {
      
      meta: { 
        col_sep: ",", 
        encoding: "utf-8",
        row_sep: "/n"
      },

      dummy_parent: {
        mother_name: "Sarah Jane Schoeneman",
        dummy_parent_id: "1"
      }
    }   
    } 
  end
end
