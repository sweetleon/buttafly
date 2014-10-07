require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController
    
    before_action :set_originable, only: [:show, :edit, :update, :destroy]

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
        render "new"
      end
    end

    def update
    end

    def destroy
    end

    def index
      if params[:state]
        files = Buttafly::Spreadsheet.where(aasm_state: params[:state])
      else
        files = Buttafly::Spreadsheet.all
      end
      @originable = Buttafly::Spreadsheet.new
      @contents = files.order(:created_at).page(params[:page]).per(5)
      @legends = Buttafly::Legend.all
      @mapping
    end

    private

    def set_originable
      @originable = Buttafly::Spreadsheet.find(params[:id])
    end

    def originable_params
      params.require(:originable).permit(:name, :flat_file)
    end
  end
end
