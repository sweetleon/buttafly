module Originable
  extend ActiveSupport::Concern

  module ClassMethods

    def originable?
      true
    end

    def targetable_models
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c| 
        c.included_modules.include?(Targetable)
      end
      model_names = models.map(&:name)
      model_names
    end
  end

  included do

    require "csv"
    require "json"
    require "roo"

    include AASM

    mount_uploader :flat_file, Buttafly::FlatFileUploader
    
    belongs_to :user
    
    has_many :mappings, as: :originable

    validates_presence_of   :flat_file
    validates_uniqueness_of :name, scope: :flat_file, allow_blank: true

    aasm do 

      state :uploaded, initial: true
      state :targeted
      state :mapped
      state :transmogrified
      state :archived

      event :target do 
        transitions from: [:uploaded, :targeted], 
                      to: :targeted
      end

      event :map do       
        transitions from: :targeted, 
                      to: :mapped
      end

      event :transmogrify do 
        transitions from: :mapped, 
                      to: :transmogrified
      end

      event :archive do 
        transitions from: [:uploaded, :targeted, :mapped, :transmogrified], 
                      to: :archived
      end
    end

    def originable_events
      events_array = aasm.events.map(&:name) - [:target, :map]
      data.nil? ? (events_array << :import) : events_array << :wipe 
    end

    def derived_name
      if name.present?
        name
      else 
        File.basename(flat_file.to_s)
      end 
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

    def targetable_order(parent=nil)
      ancestors = Hash.new
      targetable_parents(parent).each do |p|
        ancestors[p] = targetable_parents(p).empty? ? {} : targetable_order(p)
      end
      ancestors
    end

    def create_records!

      mappings.each do |m|

        # m.legend.each do |k,v|
        #   if v.is_a(Hash)
        #   else

        #   end
        # end

      end


    end
      # self.mappings.each do |mapping|
      #   tm = mapping.targetable_model.classify.constantize
      #   legend = mapping.legend_data.to_h
      #   csv = CSV.open(self.flat_file.path, headers:true).readlines
      #   csv.each do |csv_row|
      #     params_hash = {}
      #     tm.targetable_columns.each do |col|
      #       params_hash[col] = csv_row[legend.key("#{tm.to_s.downcase}::#{col}")]
      #     end
      #     # if tm.targetable_parent_models.size == 1

      #     # unless tm.targetable_parent_models.empty?
      #     #   tm.targetable_parent_models.each do |parent|
      #     #     fk = p.to_s.foreign_key
      #     #   end
      #     # end
              


      #     tm.find_or_create_by(params_hash)
      #   end
      # end
    # end

    def set_transition_timestamp(given_status, time=Time.now)
      timestamp_field = "#{given_status}_at".to_sym
      self[timestamp_field] = time
    end

    def list_headers
      data = CSV.read(self.flat_file.path)
      data.first
    end

    def may_import?
      data.nil?
    end

    def may_wipe?
      data.present?
    end

    # def convert_data_to_json!
    #   csv = CSV.open(self.flat_file.path, headers:true).readlines
    #   json_array = Array.new
    #   csv.entries.map do |entry|
    #     json_array << entry.to_hash
    #   end
    #   self.update(data: json_array)
    # end
  end
end
