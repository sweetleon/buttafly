class DummyChild < ActiveRecord::Base
  
  has_one :mapping, as: :targetable
end
