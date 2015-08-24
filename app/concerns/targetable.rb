module Targetable

  extend ActiveSupport::Concern

  module ClassMethods
    def targetable?
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
    
    TargetableModels.add self
    
    def self.targetable_ignored_columns 
      ["updated_at", "created_at", "id"]
    end

    def self.targetable_columns
      column_names - targetable_ignored_columns
    end

    def self.targetable_foreign_keys
      parents = self.reflect_on_all_associations(:belongs_to).map(&:name)
    end

    def self.targetable_attrs
      attrs = targetable_columns
      parents = self.reflect_on_all_associations(:belongs_to).map(&:name)
      parents.each do |p|
        fk = p.to_s.capitalize.foreign_key
        attrs.delete(fk)
      end
      attrs
    end  
  end
end