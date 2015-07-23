module Buttafly
  class Mapping < ActiveRecord::Base
    require 'tsortable'
    serialize :legend_data, Hash

    belongs_to :legend
    belongs_to :originable, 
      polymorphic: true, 
      class_name: "Buttafly::Spreadsheet",
      touch: true

    validates :originable,        presence: true
    validates :targetable_model,  presence: true

    after_save :set_originable_state

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

    def targetable_order(parent=nil)
      ancestors = Hash.new
      targetable_parents(parent).each do |p|
        ancestors[p] = targetable_parents(p).empty? ? {} : targetable_order(p)
      end
      ancestors
    end

    def targetable_parents(klass=nil) 
      parent_models = []
      klass ||= targetable_model
      klass.to_s.classify.constantize.reflect_on_all_associations(:belongs_to).each do |parent_model|
        if parent_model.options[:class_name].nil?
          parent_models << parent_model.name 
        else
          parent_models << parent_model.options[:class_name].constantize.model_name.i18n_key
        end
      end
      parent_models
    end


#   def targetable_order
#       dependency_hash = TsortableHash[]
#       targetable_model.classify.constantize.targetable_parent_models.each do |parent|
#         dependency_hash[parent] = parent.to_s.classify.constantize.targetable_parent_models
#         # grandparents = parent.to_s.classify.constantize.targetable_parent_models        
#       end
#       dependency_hash
#     end  
  private

    def set_originable_state
      self.originable.target! if self.originable.uploaded?
      self.originable.map! if !self.legend_data.empty? && self.originable.targeted? 
    end
  end
end