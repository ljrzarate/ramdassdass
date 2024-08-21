class ContactController < ApplicationController
  def index
  end

  def create
    unless verify_recaptcha?(params[:recaptcha_token], 'contact_us')
      flash[:error] = "Show me you're not a robot!"
      return render 'index'
    end

    ContactFormJob.perform_later(contact_params[:name], contact_params[:email], contact_params[:message])
    flash[:success] = 'Thank you for the message, soon I will be answer | Gracias por el mensaje, pronto te contestare :)'
    redirect_to contact_index_path
  end

  def contact_params
    params.permit(:name, :email, :message)
  end
end
