class DummyChild < ActiveRecord::Base
  
  include Buttafly::Targetable

  belongs_to :dummy_parent
  belongs_to :dummy_tribe

  validates :dummy_parent, presence: true
  validates :dummy_tribe, presence: true
end
