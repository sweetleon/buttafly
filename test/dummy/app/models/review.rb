class Review < ActiveRecord::Base

  include Targetable

  belongs_to :reviewer, class_name: "User"
  belongs_to :wine
end
