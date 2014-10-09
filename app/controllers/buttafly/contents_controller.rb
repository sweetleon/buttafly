require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController
    before_action :set_originable_type
    before_action :set_originable, except: [:new, :create, :index]

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
        files = @originable_type.where(aasm_state: params[:state])
      else
        files = @originable_type.all
      end
      @originable = @originable_type.new
      @contents = files.order(:created_at).page(params[:page]).per(5)
      @legends = Buttafly::Legend.all
      @mapping = Mapping.new
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
