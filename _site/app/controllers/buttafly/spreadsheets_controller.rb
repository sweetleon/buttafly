require_dependency "buttafly/application_controller"

module Buttafly
  class SpreadsheetsController < ApplicationController
    
    before_action :set_spreadsheet, except: [:create]
    

    def create
      @spreadsheet = Buttafly::Spreadsheet.new(spreadsheet_params)

      if @spreasheet.save
        redirect_to spreadsheets_path, notice: "The spreadsheet #{@spreadsheet.name} has been uploaded."
      else
        render "new"
      end
  
    end
    
    def import
    end

    def process_file
    end

    private

    def set_spreadsheet
      @spreadsheet = spreadsheet.find(params[:id])
    end

    def spreadsheet_params
      params.require(:spreadsheet).permit(:name, :flat_file)
    end
  end
end
