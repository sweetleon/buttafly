module Buttafly
  class Mapping < ActiveRecord::Base

    #associations
    belongs_to :legend
    belongs_to :originable, polymorphic: true, class_name: "Buttafly::Spreadsheet"

    # validations
    validates :legend, presence: true
    validates :originable, presence: true
  end
end
