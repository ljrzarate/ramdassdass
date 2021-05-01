class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Ram Dass Dass, Hope you enjoy the readings!')
  end
end
