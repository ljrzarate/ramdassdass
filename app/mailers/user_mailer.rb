class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Ram Dass Dass, Hope you enjoy the readings!')
  end

  def contact_form
    @params = params[:params]
    mail(to: ENV["RAMDASDASS_EMAIL"], subject: 'Contact Form - Ram Dass Dass')
  end
end
