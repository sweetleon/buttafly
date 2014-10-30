module Buttafly
  class Mapping < ActiveRecord::Base

    # associations
    belongs_to :legend
    belongs_to :originable, polymorphic: true, class_name: "Buttafly::Spreadsheet"

    # validations
    validates :originable, presence: true

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