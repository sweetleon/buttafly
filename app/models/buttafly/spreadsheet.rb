module Buttafly
  class Spreadsheet < ActiveRecord::Base

    require "csv"
    require "json"

    belongs_to :user

    has_many :mappings, as: :originable
    has_many :legends, through: :mappings
    has_many :targetable, through: :mappings

    mount_uploader :flat_file, Buttafly::FlatFileUploader

    include AASM

    aasm do 
      state :not_imported, initial: true
      state :imported, before_enter: :convert_data_to_json!

      state :processed
      state :removed
      state :ignored
      state :modified  

    end

    def set_transition_timestamp(given_status, time=Time.now)
      timestamp_field = "#{given_status}_at".to_sym
      self[timestamp_field] = time
    end

    def convert_data_to_json!
      csv_data = CSV.new(get_data!, headers: true, col_sep: self.mapping.col_sep, header_converters: :symbol)
      json_data = csv_data.map { |csv_row| csv_row.to_hash.symbolize_keys }
      self.update(purchase_data: json_data)
    end
  end
end
