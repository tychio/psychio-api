class ExperimentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ExperimentResult.save(params[:name], params[:result])

    render json: true
  end
end
