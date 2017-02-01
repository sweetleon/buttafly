require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController

    before_action :set_originable, only: [
        :edit, :show, :map, :archive, :destroy, :transmogrify, :import, :wipe]

    def create
      @originable = Buttafly::Spreadsheet.new(originable_params)
      if @originable.save
        redirect_to contents_path, notice: "#{@originable.name} has been uploaded."
      else
        redirect_to contents_path, alert: "Could not upload content"
      end
    end

    def target
    end

    def map
      # byebug
    end

    def wipe
      if @originable.wipe!
        redirect_to contents_path, notice: "#{@originable.name} successfully wiped."
      else
        redirect_to contents_path, alert: "Could not wipe #{@originable.name}."
      end
    end

    def import
      if @originable.import!
        redirect_to contents_path, notice: "#{@originable.name} successfully imported."
      else
        redirect_to :back, alert: "Could not import #{@originable.name}."
      end
    end

    def archive
      if @originable.archive!

        redirect_to :contents, notice: "#{@originable.name} successfully archived."
      else
        redirect_to :contents, notice: "#{@originable.name} could not be archived."
      end
    end

    def transmogrify
      if @originable.transmogrify!
        redirect_to :back, notice: "#{@originable.name} successfully archived."
      else
        redirect_to :back, notice: "#{@originable.name} could not be archived."
      end
    end

    def destroy
      if @originable.destroy
        redirect_to contents_path, notice: "content successfully destroyed"
      else
        redirect_to contents_path, alert: "Could not destroy content"
      end
    end

    def index
      if params[:state]
        files = Buttafly.originable.where(aasm_state: params[:state]).order(created_at: :asc)
      else
        files = Buttafly.originable.all.order(created_at: :desc)
      end

      @originable = Buttafly.originable.new
      @contents = files.order(:created_at).page(params[:page]).per(5)
      @targetable_models = @originable.targetable_models
      @mapping = Mapping.new
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
