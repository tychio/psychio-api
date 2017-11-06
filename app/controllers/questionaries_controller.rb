class QuestionariesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    data = params[:data]
    sample = LeapqSample.signup(data[:info])
    LeapqSampleInfo.fill(sample[:id], data[:info])

    render json: data
  end
end
