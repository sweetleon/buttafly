# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :legend, :class => 'Buttafly::Legend' do

    data { {
      
      meta: { 
        col_sep: ",", 
        encoding: "utf-8",
        row_sep: "/n",
        headers: ["mother", "child", "grandparent"]
      },

      dummy_child: {
        name: "child",
        dummy_parent: {
          name: "mother", 
          dummy_grandparent: { 
            name: "grandparent"}
          }
        }
      }   
    } 
  end
end
