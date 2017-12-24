class AnalysesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    standard = AnalysisGroup.standard
    render json: standard
  end

  def update
  	AnalysisGroup.collect
  end
end
