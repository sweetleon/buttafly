require_dependency "buttafly/application_controller"

module Buttafly
  class MappingsController < ApplicationController

    def new
      legends = Mapping.where(targetable_model: params).map(&:legend_id)
    end

    def show
    end

    def edit
    end

    def index
    end

    def update
      @mapping = Buttafly::Mapping.find(params[:id])
      if @mapping.update(legend_data: mapping_params[:data].to_a)
        
        redirect_to contents_path, notice: "mapping updated"
      else
        redirect_to :back, alert: "mapping did not update"
      end  
    end

    def destroy
      @mapping = Buttafly::Mapping.find(params[:id])
      if @mapping.destroy
        redirect_to :back, notice: "mapping destroyed"
      else
        redirect_to :back, notice: "can't destroy mapping"
      end
    end

    def create
      @mapping = Buttafly::Mapping.new(mapping_params)    
      if @mapping.update(originable_type: Buttafly.originable.to_s)
        redirect_to :back, notice: "mapping created"
      else
        redirect_to :back, notice: "not good"
      end
    end

   private

    def set_originable
      @originable = Buttafly.originable.find(params[:originable_id])
    end

    def mapping_params
      params.require(:mapping).permit!
    end
  end
end
