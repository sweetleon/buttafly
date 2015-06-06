require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController

    before_action :set_legend, only: [:show, :edit, :update]

    def new
      @mapping = Buttafly::Mapping.find(params[:mapping_id])
      @legend = @mapping.build_legend
      @headers = @mapping.get_origin_headers
      @new_record = @mapping.targetable_model.constantize.new
    end

    def create
      @legend = Buttafly::Legend.new(data: legend_params)
      if @legend.save
        redirect_to contents_path, notice: "legend created"
      else
        redirect_to :back, notice: "not good"
      end
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

      params.require(:legend)
    end
  end
end
