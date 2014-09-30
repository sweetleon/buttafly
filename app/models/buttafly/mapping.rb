module Buttafly
  class Mapping < ActiveRecord::Base

    #associations
    belongs_to :legend
    belongs_to :originable, polymorphic: true
    belongs_to :targetable, polymorphic: true

    # validations
    validates :legend, presence: true
  end
end
