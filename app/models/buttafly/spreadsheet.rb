module Buttafly
  class Spreadsheet < ActiveRecord::Base

    require "csv"
    require "json"
    require "roo"

    belongs_to :user

    has_many :mappings, as: :originable
    has_many :legends, through: :mappings
    has_many :targetable, through: :mappings, source: :targetable, source_type: "DummyChild"

    mount_uploader :flat_file, Buttafly::FlatFileUploader

    include AASM

    aasm do 

      state :not_imported, initial: true
      state :imported, before_enter: :convert_data_to_json!
      state :published
      state :unpublished

      event :import do 
        transitions from: [:not_imported, :imported], 
                    to: :imported, 
                    on_transition: -> f { f.set_transition_timestamp :imported }
      end

      event :publish do 
        transitions from: [:imported, :unpublished],
                    to: :published, 
                    on_transition: -> f { f.set_transition_timestamp :published}
      end

      event :unpublish do 
        transitions from: :published
      end
    end

    def set_transition_timestamp(given_status, time=Time.now)
      timestamp_field = "#{given_status}_at".to_sym
      self[timestamp_field] = time
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
end
