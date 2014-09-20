module Buttafly
  class Spreadsheet < ActiveRecord::Base

    belongs_to :user

    has_many :mappings, as: :originable
    has_many :legends, through: :mappings
    has_many :targetable, through: :mappings

  end
end
