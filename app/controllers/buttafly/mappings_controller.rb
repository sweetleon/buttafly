require_dependency "buttafly/application_controller"

module Buttafly
  class MappingsController < ApplicationController

    # before_action :set_originable, on: :new

    def new
      # binding.pry
      # @originable = Buttafly.originable.find(id: params[:originable_id])
      # legends = Mapping.where(targetable_model: params).map(&:legend_id)
    end

    def show
    end

    def edit
    end

    def index
    end

    def update
    end

    def destroy
    end

    def create
      @mapping = Buttafly::Mapping.new(mapping_params)    
      if @mapping.update(originable_type: Buttafly.originable.to_s)
        redirect_to :back, notice: "mapping created"
      end
    end

   private

    def set_originable
      @originable = Buttafly.originable.find(params[:originable_id])
    end

    def mapping_params
      params.require(:mapping).permit(:originable_id, :targetable_model)
    end
  end
end
