class Paypal::Orders::Updater

  attr_reader :user_id, :charge_id, :order_id, :post_id

  def initialize(user_id:, charge_id:, order_id:, post_id:)
    @user_id = user_id
    @charge_id = charge_id
    @order_id = order_id
    @post_id = post_id
  end

  def execute
    order = Order.find_by(
      token: order_id,
      post_id: post_id,
      status: Order.statuses[:pending]
    )

    order.user_id         = user_id
    order.charge_id       = charge_id
    order.payment_gateway = :paypal
    order.status          = Order.statuses[:paypal_executed]
    order.save!
    order
  end
end