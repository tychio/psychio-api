class AnalysesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		render json: {}
	end
end
