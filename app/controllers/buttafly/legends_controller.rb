require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController

    before_action :set_legend, only: [:show, :edit, :update]

    def new
      @mapping = Buttafly::Mapping.find(params[:mapping_id])
      @legend = @mapping.build_legend
    end

    def show
    end

    def edit
    end

    def index
    end

   private

    def set_legend
      @legend = Buttafly::Legend.find(params[:legend_id])
    end

    def legend_params

      params.require(:legend).permit(:name, :data, :cartographer_id, mapping: [ :id, :targetable_model, :originable_id ])
    end
  end
end
