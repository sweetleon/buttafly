module Buttafly
  class Legend < ActiveRecord::Base

    belongs_to :cartographer, class_name: "User"
    
    has_many :mappings
    has_many :targetable, through: :mappings
    has_many :originable, through: :mappings
  end
end
