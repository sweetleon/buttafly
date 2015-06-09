module Buttafly
  module MappingHelper

    def field_choices(targetable_model)
      m = targetable_model.classify.constantize
      fields = m.targetable_attrs
      m.parent_models.each do |p|
        attrs = p.to_s.classify.constantize.targetable_attrs
        # attrs.each do |a|
        #   fields << "#{p}:#{a}"
          
        # end
      end
      fields
    end


  end
end
