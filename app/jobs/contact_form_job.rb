class ContactFormJob < ApplicationJob
  queue_as :default

  def perform(params)
    UserMailer.with(params: params).contact_form.deliver_now
  end
end
