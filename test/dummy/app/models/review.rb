class Review < ActiveRecord::Base

  include Targetable

  belongs_to :reviewer, class_name: "User"
  belongs_to :wine

  validates :wine, presence: true
  validates :reviewer, presence: true

end
