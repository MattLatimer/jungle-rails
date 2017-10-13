class OrderMailer < ApplicationMailer

  def order_received(order)
    @order = order
    @line_items = @order.line_items
    mail(to: @order.email, subject: "Jungle Order ##{@order.id}")
  end

end
