class User < ActiveRecord::Base

  include Targetable

  has_many :reviews
end
