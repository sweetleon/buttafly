module Buttafly
  class Legend < ActiveRecord::Base

    belongs_to :cartographer, class_name: "User"
    
    has_many :mappings
    has_many :targetable, through: :mappings
    has_many :originable, through: :mappings, source_type: "Originable"
    
    accepts_nested_attributes_for :mappings
    
    def self.get_origin_keys(model, id)
      json_columns = []
      hash_of_keys = {}
      model.columns_hash.each do |column_hash|
        if column_hash[1].type == :json
          json_columns << column_hash[1].name
        end
      end
      json_columns.each do |column|
        file = model.find(id)
        origin_keys = eval("file.#{column}")
        hash_of_keys[column] = origin_keys.first.keys
      end
      hash_of_keys
    end

    def self.ancestors_hash(model)
      ancestors = self.get_dependencies(model)
      level_one = []
      ancestors[:parents].each_with_index do |p,i|
        level_one << {p => self.get_dependencies(p) }
        ancestors[:parents] = level_one 
        level_two = []
        ancestors[:parents][i][p][:parents].each_with_index do |g, n|
          level_two << { g => self.get_dependencies(g) }
          ancestors[:parents][i][p][:parents] = level_two
          level_three = []
          ancestors[:parents][i][p][:parents][n][g][:parents].each do |ggp|
            level_three << { ggp => self.get_dependencies(ggp) }
            ancestors[:parents][i][p][:parents][n][g][:parents] = level_three
          end
        end
      end
      ancestors
    end

    def self.get_target_keys(model)
      model.to_s.classify.constantize.column_names - @ignored_columns
    end

    def self.get_parent_models(model)
      model.to_s.classify.constantize.validators.map(&:attributes).flatten
    end

    def self.targetable_models
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c| 
        c.included_modules.include?(Targetable)
      end
      model_names = models.map(&:name)
      model_names
    end

    def self.originable_models      
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c| 
        c.included_modules.include?(Originable)
      end
      model_names = models.map(&:name)
      model_names
    end

    def self.get_dependencies(model)
      {
        :attrs => self.get_target_keys(model),
        :parents => self.get_parent_models(model)
      }

    end

    # def map_origin_to_target(originable, targetable_model)
    #   mapping = self.mappings.new( originable_id: originable.id, 
    #                         originable_type: originable.class,
    #                         targetable_model: "blah")
      
    #   mapping.save
    # end
   private
  
    @ignored_columns = ["created_at", "id", "updated_at"]
    @ignored_models = [:mapping, :spreadsheet, :legend]
  end
end
