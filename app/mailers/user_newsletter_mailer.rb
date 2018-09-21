class UserNewsletterMailer < ApplicationMailer
  default from: 'notifications@LIFO.com'
 
  def weekly_email
    @user = params[:user]
    @url  = params[:url]
    mail(to: @user.email, subject: 'Your week at a glance!')
  end
end
