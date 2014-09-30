class DummyChild < ActiveRecord::Base
  
  belongs_to :dummy_parent
  belongs_to :dummy_address

  has_one :mapping, as: :targetable

  validates :dummy_parent, presence: true
  validates :dummy_address, presence: true
end
