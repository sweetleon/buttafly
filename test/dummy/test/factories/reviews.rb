# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    rating 1
    content "MyText"
    reviewer_id 1
    wine_id 1
  end
end
