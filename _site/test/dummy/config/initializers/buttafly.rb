module Buttafly

  def self.originable
    # Flat files are managed in the Spreadsheet model by default.  If you would like to use a different model of your own creation, please specify the model name here.      
    
    Spreadsheet
  end
end