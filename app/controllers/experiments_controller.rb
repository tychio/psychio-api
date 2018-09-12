class ExperimentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    ExperimentResult.save(params[:name], params[:result])

    render json: true
  end

  def show
    results = ExperimentTrial.list params[:type].to_sym

    thresholds = ExperimentTrial.thresholds results
    grouped_results = results.group_by { |result| result.group }
    handled_results = Hash.new
    grouped_results.each do |group_name, results|
      results_hash = results.map do |result|
        result.to_hash thresholds[result[:key]]
      end
      handled_results[group_name] = results_hash.group_by do |result|
        result[:key]
      end
    end

    render json: handled_results
  end
end
