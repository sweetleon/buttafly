class Wine < ActiveRecord::Base

  include Targetable

  belongs_to :winery
  has_many :reviews
end
