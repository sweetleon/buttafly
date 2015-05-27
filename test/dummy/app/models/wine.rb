class Wine < ActiveRecord::Base

  belongs_to :winery
  has_many :reviews
end
