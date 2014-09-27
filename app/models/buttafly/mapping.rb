module Buttafly
  class Mapping < ActiveRecord::Base

    #associations
    belongs_to :legend
    belongs_to :originable, polymorphic: true
    belongs_to :targetable, polymorphic: true

    # validations
    validates :legend, presence: true

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
  end
end
