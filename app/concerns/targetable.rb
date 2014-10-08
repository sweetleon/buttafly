module Targetable
  extend ActiveSupport::Concern

  module ClassMethods
    def targetable
      true
    end
  end

  module TargetableModels
    extend self
    @included_in ||= []

    def add(klass)
      @included_in << klass
    end

    def included_in
      @included_in
    end
  end

  included do
    has_one :mapping, as: :targetable
    TargetableModels.add self
  end
end