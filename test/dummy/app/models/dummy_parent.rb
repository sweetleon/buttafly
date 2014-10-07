class DummyParent < ActiveRecord::Base

  include Targetable

  belongs_to :dummy_grandparent
  belongs_to :dummy_tribe
  
  has_many :dummy_children
  has_many :dummy_grandchildren,  through: :dummy_parents, 
                                  class_name: "DummyChildren"

  validates :dummy_grandparent, presence: true
  validates :dummy_tribe, presence: true
end
