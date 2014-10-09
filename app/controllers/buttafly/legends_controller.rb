require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController

    before_action :set_originable, on: :new

    def new
      @mapping = @originable.mappings.new
    
    end

    def show
    end

    def edit
    end

    def index
    end

   private

    def set_originable
      @originable = Buttafly.originable.find(params[:originable_id])
    end

    def originable_params
      params.require(:originable).permit(:name, :flat_file)
    end
  end
end
