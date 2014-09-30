class DummyGrandparent < ActiveRecord::Base

  belongs_to :dummy_address

  validates :dummy_address, presence: true
end
