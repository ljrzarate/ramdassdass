class ContactFormJob < ApplicationJob
  queue_as :mailers

  def perform(name, email, message)
    params = {name: name, email: email, message: message}
    UserMailer.with(params: params).contact_form.deliver_later(wait: 1.minute)
  end
end
