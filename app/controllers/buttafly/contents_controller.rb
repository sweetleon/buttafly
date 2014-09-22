require_dependency "buttafly/application_controller"

module Buttafly
  class ContentsController < ApplicationController
    
    def new
    	@originable = Buttafly.originable.new
    end

    def show
    end

    def edit
    end

    def create
    end

    def update
    end

    def destroy
    end

    def index
    end
  end
end
