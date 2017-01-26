module Originable
  extend ActiveSupport::Concern

  module ClassMethods

    def originable?
      true
    end
  end

  included do

    require "csv"
    require "json"
    require "roo"
    require "tsortable"

    include AASM

    mount_uploader :flat_file, Buttafly::FlatFileUploader

    has_many :mappings, as: :originable

    validates_presence_of   :flat_file
    validates_uniqueness_of :name, scope: :flat_file, allow_blank: true

    aasm do

      state :uploaded, initial: true
      state :mapped
      state :transmogrified
      state :archived

      event :map do
        transitions from: :uploaded,
                      to: :mapped
      end

      event :transmogrify do
        transitions from: :mapped,
                      to: :transmogrified
      end

      event :archive do
        transitions from: [:uploaded, :mapped, :transmogrified],
                      to: :archived
      end
    end

    def originable_events
      events_array = aasm.events.map(&:name)
      data.nil? ? (events_array << :import) : events_array << :wipe
    end

    def disabled_originable_events
      Buttafly::Spreadsheet.aasm.events.map(&:name) - Buttafly::Spreadsheet.first.aasm.events.map(&:name)
    end

    def originable_headers
      data = CSV.read(flat_file.path)
      data.first
    end

    def derived_name
      if name.present?
        name
      else
        File.basename(flat_file.to_s)
      end
    end

    def targetable_models
      Rails.application.eager_load!
      models = ActiveRecord::Base.descendants.select do |c|
        c.included_modules.include?(Targetable)
      end
      model_names = models.map(&:name)
      model_names
    end

    def targetable_parents(klass=nil)
      parent_models = []
      klass.to_s.classify.constantize.reflect_on_all_associations(:belongs_to).each do |parent_model|
        if parent_model.options[:class_name].nil?
          parent_models << parent_model.name
        else
          parent_models << parent_model.options[:class_name].constantize.model_name.i18n_key
        end
      end
      parent_models
    end

    def tsorted_order
      dependency_hash = TsortableHash[]
      targetable_models.each do |m|
        dependency_hash[m.underscore.to_sym] = parents_of(m)
      end
      dependency_hash
    end

    def parents_of(klass)
      parent_models = []
      klass.to_s.classify.constantize.reflect_on_all_associations(:belongs_to).each do |parent_model|
        if parent_model.options[:class_name].nil?
          parent_models << parent_model.name
        else
          parent_models << parent_model.options[:class_name].constantize.model_name.i18n_key
        end
      end
      parent_models
    end

    def ancestors_of(klass, ancestorsHash=nil)
      ancestorsHash ||= {}
      ancestorsHash[klass] = parents_of(klass)
      ancestorsHash.each do |key, value|

        if value.empty?
          return
        else
          ancestorsHash[key] = parents_of(key)
        end
      end
      ancestorsHash.values.first
    end

    def legend
      mappings.last.legend
    end

    def create_records!
      csv = CSV.open(self.flat_file.path, headers:true).readlines
      csv.each { |row| create_records_from_row(row) }
    end

    def create_records_from_row(row)
      legend.each do |key, value|
        create_record(key, value, row, {})
      end
    end

    def create_record(model, hash, row, parent_attrs)
      attrs ||= {}
      hash.each do |key, value|
        if value.is_a? Hash
          parent = klassify(model).reflect_on_association(key).class_name
          x = create_record(parent, value, row, attrs)
          attrs["#{key}_id"] = x.id
        else
          attrs[key] = row[value]
        end
      end
      klassify(model).where(attrs).first_or_create
    end

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

    def import!
      convert_data_to_json!
    end

    def wipe!
      update(data: nil)
    end

    def convert_data_to_json!
      csv = CSV.open(self.flat_file.path, headers:true).readlines
      json_array = Array.new
      csv.entries.map do |entry|
        json_array << entry.to_hash
      end
      self.update(data: json_array)
    end
  end

  private

    def klassify(string)
      string.classify.constantize
    end
end
