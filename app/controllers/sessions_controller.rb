class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error_message] = "Invalid username and/or password."
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "You've been logged out"
    redirect_to root_path
  end

end