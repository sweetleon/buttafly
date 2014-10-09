require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController

    before_action :set_originable#, except: [:new, :create, :index]

    def new
      binding.pry
      # @originable = Buttafly::Legend.
    
    end

    def show
    end

    def edit
    end

    def index
    end

   private

    def set_originable
      set_originable_type
      @originable = @originable_type.find(params[:id])
    end

    def set_originable_type
      @originable_type = Buttafly::Spreadsheet
    end

    def originable_params
      params.require(:originable).permit(:name, :flat_file)
    end
  end
end
