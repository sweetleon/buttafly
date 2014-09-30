module Buttafly
  class Legend < ActiveRecord::Base

    belongs_to :cartographer, class_name: "User"
    
    has_many :mappings
    has_many :targetable, through: :mappings
    has_many :originable, through: :mappings
    
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

    def self.get_target_keys(model)
      model.to_s.classify.constantize.column_names - @ignored_columns
    end

    def self.get_parent_models(model)
       model.to_s.classify.constantize.validators.map(&:attributes).flatten
    end

    def self.get_ancestor_models(model)
      ancestors = []
      parents = self.get_parent_models(model)
      parents.each do |parent|
        parent = { parent => { attrs: self.get_target_keys(parent)}}
        ancestors << parent
      end
      ancestors
    end
  
    private

    @ignored_columns = ["created_at", "id", "updated_at"]
    @ignored_models = [:mapping, :spreadsheet, :legend]
  end
end
