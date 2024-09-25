class Paypal::Users::Creator

  attr_reader :paypal_attrs

  def initialize(paypal_attrs: {})
    @paypal_attrs = paypal_attrs
  end

  def execute
    user = User.find_or_initialize_by(email: paypal_attrs[:email_address])

    if user.new_record?
      user.password              = paypal_attrs[:payer_id]
      user.password_confirmation = paypal_attrs[:payer_id]
    end
    user.payer_id   = paypal_attrs[:payer_id] if user.payer_id.blank?
    user.first_name = paypal_attrs[:name][:given_name]
    user.last_name  = paypal_attrs[:name][:surname]
    user.save!
    user
  end
end