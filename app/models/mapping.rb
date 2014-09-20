module Buttafly
  class Mapping < ActiveRecord::Base
    require "csv"
    require "json"

    belongs_to :legend
    belongs_to :originable, polymorphic: true
    belongs_to :targetable, polymorphic: true
  end
end
