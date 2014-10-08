module Buttafly

  class Spreadsheet < ActiveRecord::Base

    include Originable

    mount_uploader :flat_file, Buttafly::FlatFileUploader
  end
end
