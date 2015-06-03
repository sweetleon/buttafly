module Originable
  extend ActiveSupport::Concern

  included do

    require "csv"
    require "json"
    require "roo"

    include AASM

    belongs_to :user
    
    has_many :mappings, as: :originable
    has_many :legends, through: :mappings

    mount_uploader :flat_file, Buttafly::FlatFileUploader
    validates_presence_of :flat_file

    aasm do 

      # initial state, after successful upload.
      state :uploaded, initial: true
      state :targeted
      state :mapped
      state :transferred
      state :destroyed
      state :archived

      event :target do 
        transitions from: :uploaded, to: :targeted, 
                    after: -> f { f.set_transition_timestamp :targeted}
      end

      # cruft?
      state :not_imported
      state :imported, before_enter: :convert_data_to_json!
      state :published
      state :unpublished

      # event :import do 
      #   transitions from: [:not_imported, :imported], 
      #               to: :imported, 
      #               on_transition: -> f { f.set_transition_timestamp :imported }
      # end


      event :publish do 
        transitions from: [:imported, :unpublished],
                    to: :published, 
                    on_transition: -> f { f.set_transition_timestamp :published}
      end

      event :unpublish do 
        transitions from: :published
      end
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

    # def convert_data_to_json!
    #   csv = CSV.open(self.flat_file.path, headers:true).readlines
    #   json_array = Array.new
    #   csv.entries.map do |entry|
    #     json_array << entry.to_hash
    #   end
    #   self.update(data: json_array)
    # end
  end
  
  module ClassMethods

    def originable
      true
    end
  end
end
