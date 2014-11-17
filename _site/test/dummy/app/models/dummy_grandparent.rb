class DummyGrandparent < ActiveRecord::Base

  include Targetable

  belongs_to :dummy_tribe

  validates :dummy_tribe, presence: true
end
