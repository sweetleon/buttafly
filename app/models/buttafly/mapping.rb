module Buttafly
  class Mapping < ActiveRecord::Base
    require 'tsortable'
    serialize :data

    belongs_to :legend
    belongs_to :originable, polymorphic: true, class_name: "Buttafly::Spreadsheet"

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
    
    def originable_headers
      data = CSV.read(self.originable.flat_file.path)
      data.first
    end

    def targetable_field_choices
      choices = self.targetable_model.classify.constantize.targetable_attrs
      self.targetable_order.flatten.flatten.each do |parent|
        parent.to_s.classify.constantize.targetable_attrs.each do |attribute|
          choices << "#{parent}::#{attribute}"
        end
      end
      choices
    end


    def targetable_order
      dependency_hash = TsortableHash[]
      targetable_model.classify.constantize.targetable_parent_models.each do |parent|
        dependency_hash[parent] = parent.to_s.classify.constantize.targetable_parent_models
        grandparents = parent.to_s.classify.constantize.targetable_parent_models        
      end
      dependency_hash
    end
  end
end