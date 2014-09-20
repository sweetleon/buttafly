module Buttafly
  class Legend < ActiveRecord::Base

    belongs_to :cartographer, class_name: "User"
    
    has_many :mappings
  end
end
