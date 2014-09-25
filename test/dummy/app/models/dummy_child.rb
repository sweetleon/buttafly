class DummyChild < ActiveRecord::Base
  
  belongs_to :dummy_parent
  has_one :mapping, as: :targetable

end
