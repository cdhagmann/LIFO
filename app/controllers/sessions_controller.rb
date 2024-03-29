# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    session[:return_to] = request.referer
    user = User.find_by_username(params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
    else
      flash[:error_message] = 'Invalid username and/or password.'
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    session[:user_id] = nil
    # flash[:notice] = "You've been logged out"
    redirect_to session.delete(:return_to)
  end
end
