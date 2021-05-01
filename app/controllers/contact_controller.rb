class ContactController < ApplicationController
  def index
  end

  def create
    ContactFormJob.perform_later(contact_params)
  end

  def contact_params
    params.permit(:name, :email, :message)
  end
end
