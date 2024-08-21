class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Ramminti, Hope you enjoy the readings!')
  end

  def contact_form
    @params = params[:params]
    mail(to: ENV["RAMDASDASS_EMAIL"], subject: 'Contact Form - Ramminti')
  end
end
