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

    include AASM

    mount_uploader :flat_file, Buttafly::FlatFileUploader
    
    belongs_to :user
    
    has_many :mappings, as: :originable
    has_many :legends, through: :mappings

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
      name.present? ? name : File.basename(flat_file.to_s)
    end

    def create_records!

      self.mappings.each do |mapping|
#         tm = mapping.targetable_model.classify.constantize
#         legend = mapping.legend_data.to_h
#         csv = CSV.open(self.flat_file.path, headers:true).readlines
#         csv.each do |csv_row|
# byebug
#           params_hash = {}
#           tm.targetable_columns.each do |col|
#             params_hash[col] = csv_row[legend.key("#{tm.to_s.downcase}::#{col}")]
#           end
#           tm.find_or_create_by(params_hash)
        end
      end
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
