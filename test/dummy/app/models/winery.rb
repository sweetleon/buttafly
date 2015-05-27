class Winery < ActiveRecord::Base

  include Targetable

  has_many :wines
end
