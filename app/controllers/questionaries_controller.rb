class QuestionariesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		render json: params
	end
end
