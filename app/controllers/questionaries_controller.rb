class QuestionariesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    data = params[:data]
    sample = LeapqSample.signup(data[:info])
    sample.fill_info(data[:info])
    sampleLanguages = sample.sort_languages(data)
    sample.save_rates(data[:levelRates], sampleLanguages)
    sample.save_barriers(data[:levelBarriers])

    render json: data
  end
end
