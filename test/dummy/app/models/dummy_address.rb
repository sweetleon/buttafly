class DummyAddress < ActiveRecord::Base

  has_many :dummy_children
  has_many :dummy_parents
  has_many :dummy_grandparents
end
