require_dependency "buttafly/application_controller"

module Buttafly
  class SpreadsheetsController < ApplicationController
    
    before_action :set_spreadsheet, only: [:show, :edit, :update, :destroy]
    
    def create
      binding.pry
      @spreadsheet = Buttafly::Spreadsheet.new(spreadsheet_params)
      if @spreadsheet.save
        flash[:notice] = "right on"
        redirect_to :back
      else
        flash[:notice] = "sad"
        redirect_to :back
      end

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
