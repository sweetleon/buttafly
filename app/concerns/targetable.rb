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
    
    def self.targetable_attrs
      associated_cols = self.class.reflect_on_all_associations(:belongs_to)
      foreign_key_cols = associated_cols.map(&:foreign_key)
      meta_cols = ["updated_at", "created_at", "id"]
      ignored_cols = meta_cols + foreign_key_cols
      mappable_columns = self.attributes.keys - ignored_cols
    end

    def self.targetable_attrs
      associated_cols = self.reflect_on_all_associations(:belongs_to)
      foreign_key_cols = associated_cols.map(&:foreign_key)
      meta_cols = ["updated_at", "created_at", "id"]
      ignored_cols = meta_cols + foreign_key_cols
      mappable_columns = self.column_names - ignored_cols
    end

    def self.parent_models
      # self.reflect_on_all_associations(:belongs_to).first.class_name
      self.validators.map(&:attributes).flatten
    end
  end
end