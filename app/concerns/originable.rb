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

    validates :flat_file, presence: true
    
    aasm do 

      state :uploaded, initial: true
      state :targeted
      state :mapped
      state :replicated
      state :destroyed
      state :archived

      event :target do 
        transitions from: [:uploaded, :targeted], 
                      to: :targeted
      end

      event :map do       
        transitions from: :targeted, 
                      to: :mapped
      end

      event :replicate do 
        transitions from: :mapped, 
                      to: :replicated
      end

      event :archive do 
        transitions from: [:uploaded, :targeted, :mapped, :replicated], 
                      to: :archived
      end


      event :destroy do 
        transitions from: :archived

      end
    end

    def possible_events
      events_array = aasm.events.map(&:name)
      data.nil? ? (events_array << :import) : events_array << :wipe 
    end


    def derived_name
      if name.present?
        name
      else 
        File.basename(flat_file.to_s)
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
