module Buttafly
  class Spreadsheet < ActiveRecord::Base

    require "csv"
    require "json"
    require "roo"

    belongs_to :user

    has_many :mappings, as: :originable
    has_many :legends, through: :mappings
    has_many :targetable, through: :mappings

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
      csv_data = CSV.new(self.flat_file.path)
      binding.pry
      json_data = csv_data.map { |csv_row| csv_row.to_hash.symbolize_keys }
      self.update(purchase_data: json_data)
    end
  end
end
