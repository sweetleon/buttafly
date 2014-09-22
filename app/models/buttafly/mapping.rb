module Buttafly
  class Mapping < ActiveRecord::Base

    belongs_to :legend
    belongs_to :originable, polymorphic: true
    belongs_to :targetable, polymorphic: true
  end
end
