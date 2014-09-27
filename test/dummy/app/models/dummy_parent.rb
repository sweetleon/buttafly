class DummyParent < ActiveRecord::Base

  has_many :dummy_children
  has_many :dummy_grandchildren, through: :dummy_parents, class_name: "DummyChildren"
  belongs_to :grandparent, class_name: "DummyParent"
end
