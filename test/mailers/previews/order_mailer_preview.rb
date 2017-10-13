class OrderMailerPreview < ActionMailer::Preview

  
  def order_received
    @order = Order.last
    OrderMailer.order_received(@order)
  end
end