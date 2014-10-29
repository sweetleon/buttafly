require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController

    before_action :set_originable, only: [:edit, :show, :import]

    def new
      @originable = Buttafly::Spreadsheet.new
    end

    def show
    end

    def edit
    end

    def create
      @originable = Buttafly::Spreadsheet.new(originable_params)

      if @originable.save
        redirect_to contents_path, notice: "#{@originable.name} has been uploaded."
      else
        redirect_to :root, notice: "Could not upload content"
      end
    end

    def import
      if @originable.import!
        redirect_to :back, notice: "#{@originable.name} successfully imported" 
      else
        redirect_to :back, alert: "Could not import #{@originable.name}." 
      end
    end


    def patch
    end

    def destroy
    end

    def index
      if params[:state]
        files = Buttafly.originable.where(aasm_state: params[:state])
      else
        files = Buttafly.originable.all
      end
      @originable = Buttafly.originable.new
      @contents = files.order(:created_at).page(params[:page]).per(5)
      @legends = Buttafly::Legend.all
      @mapping = Mapping.new
      @targetable_models = Buttafly::Legend.targetable_models

    end

    private

    def set_originable
      @originable = Buttafly.originable.find(params[:id])
    end

    def originable_params
      params.require(:originable).permit(:name, :flat_file, :id)
    end
  end
end
