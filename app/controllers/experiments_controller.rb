class ExperimentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ExperimentResult.save(params[:name], params[:result])

    render json: true
  end

  def show
  	results = ExperimentTrial.list params[:type].to_sym

  	handled_results = results.map { |result| result.to_hash }

  	render json: handled_results
  end
end
