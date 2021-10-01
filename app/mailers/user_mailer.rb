# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@LIFO.com'

  def alert_email
    @user = params[:user]
    @url = params[:url]
    mail(to: @user.email, subject: "Ahoy, #{@user.username}!")
  end
end
