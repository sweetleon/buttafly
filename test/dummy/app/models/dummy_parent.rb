class DummyParent < ActiveRecord::Base

  belongs_to :dummy_grandparent
  belongs_to :dummy_address
  
  has_many :dummy_children
  has_many :dummy_grandchildren,  through: :dummy_parents, 
                                  class_name: "DummyChildren"

  validates :dummy_grandparent, presence: true
  validates :dummy_address, presence: true
end
