module Buttafly
  class Mapping < ActiveRecord::Base
    require 'tsortable'
    serialize :data

    # associations
    belongs_to :legend
    belongs_to :originable, polymorphic: true, class_name: "Buttafly::Spreadsheet"

    # validations
    validates :originable,        presence: true
    validates :targetable_model,  presence: true

    def self.originable_models      
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c| 
        c.included_modules.include?(Originable)
      end
      model_names = models.map(&:name)
      model_names
    end

    def self.targetable_models
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c| 
        c.included_modules.include?(Targetable)
      end
      model_names = models.map(&:name)
      model_names
    end

    def targetable_order
      dependency_hash = TsortableHash.new
      Mapping.targetable_models.each do |m|
        dependency_hash[m.underscore.to_sym] = m.constantize.validators.map(&:attributes).flatten
      end
      sorted_dependencies = dependency_hash.tsort
      sorted_dependencies[0..sorted_dependencies.index(self.targetable_model.underscore.to_sym)]
    end

    def self.targetable_order(targetable_model=nil)
      dependency_hash = TsortableHash.new
      self.targetable_models.each do |m|
        dependency_hash[m.underscore.to_sym] = m.constantize.validators.map(&:attributes).flatten
      end
      sorted_dependencies = dependency_hash.tsort
      if targetable_model.nil?
        sorted_dependencies
      else
        sorted_dependencies[0..sorted_dependencies.index(targetable_model)]
      end
    end

    def get_origin_headers
      data = CSV.read(self.originable.flat_file.path)
      data.first
    end

    def parent_models
      model = self.targetable_model.to_s.classify.constantize
      model.validators.map(&:attributes).flatten
    end
#     def self.ancestors_hash(model)
# def self.get_target_keys(model)
#       def self.get_parent_models(model)
#     def self.get_dependencies(model)
#       {
#         :attrs => self.get_target_keys(model),
#         :parents => self.get_parent_models(model)
#       }

    # end
 # end
    # private
  
    # @ignored_models = [:mapping, :spreadsheet, :legend]
  end
end