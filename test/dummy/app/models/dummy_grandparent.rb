class DummyGrandparent < ActiveRecord::Base

  belongs_to :dummy_tribe

  validates :dummy_tribe, presence: true
end
