module Originable
  extend ActiveSupport::Concern

  included do

    belongs_to :user
    
    has_many :mappings, as: :originable
    has_many :legends, through: :mappings
  end
  
  module ClassMethods

    def originable
      true
    end
  end
end
