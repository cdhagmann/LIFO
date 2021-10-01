# frozen_string_literal: true

module API
  class SessionsController < ApplicationController
    def create
      user = User.find_by_username(params[:username])

      if user&.authenticate(params[:password])
        render json: { token: user.api_token }
      else
        render json: { error: 'Invalid' }, status: :unauthorized
      end
    end
  end
end
