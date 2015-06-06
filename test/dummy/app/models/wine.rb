class Wine < ActiveRecord::Base

  include Targetable

  belongs_to :winery
  has_many :reviews

  validates :winery, presence: true

end
