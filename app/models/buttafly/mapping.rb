module Buttafly
  class Mapping < ActiveRecord::Base
    # require 'tsortable'
    serialize :legend, Hash

    belongs_to :originable,
      polymorphic: true,
      class_name: "Buttafly::Spreadsheet",
      touch: true

    validates :originable,        presence: true

    after_save :set_originable_state

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

  private

    def set_originable_state
      # self.originable.target! if self.originable.uploaded?
      self.originable.map! if !self.legend.empty? #&& self.originable.targeted?
    end
  end
end