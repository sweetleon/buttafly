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
    has_one :mapping, as: :targetable
    TargetableModels.add self
    
    def self.targetable_ignored_columns 
      ["updated_at", "created_at", "id"]
    end

    def self.targetable_columns
      column_names - targetable_ignored_columns
    end

    def self.targetable_parent_models
      parent_models = []
      self.reflect_on_all_associations(:belongs_to).each do |parent_model|
        if parent_model.options[:class_name].nil?
          parent_models << parent_model.name 
        else
          parent_models << parent_model.options[:class_name].constantize.model_name.i18n_key
        end
      end
      parent_models
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