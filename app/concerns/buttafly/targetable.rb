module Targetable
  extend ActiveSupport::Concern

  included do 
    has_one :mapping, as: :targetable

  end

  module ClassMethods
    def targetable
      true
    end
  end
end
