require_dependency "buttafly/application_controller"

module Buttafly
  class LegendsController < ApplicationController

    before_action :set_originable, on: :new

    def new
      @legend = Buttafly::Legend.create
      @mapping = @legend.mappings.new(
        originable_id: @originable.id,
        originable_type: Buttafly.originable)
      @targetable_models = Buttafly::Legend.targetable_models
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

    def legend_params
      params.require(:originable).permit(:name, :flat_file)
    end
  end
end
