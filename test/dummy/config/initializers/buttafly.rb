module Buttafly

  def self.originable
    # Flat files are managed in the Spreadsheet model by default.  If you would 
    # like to use your own model, specify this here.    
    
    Spreadsheet
  end
end