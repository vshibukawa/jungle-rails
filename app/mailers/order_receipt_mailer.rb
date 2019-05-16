class OrderReceiptMailer < ApplicationMailer

  layout "mailer"

  def order_receipt(order, url)
    @order = order
    @url = url
    @items = LineItem.where order_id: @order.id
    @items.each do |item|
      item.product = Product.find_by id: item.product_id
    end

    mail to: @order.email, subject: "[Jungle] Order Receipt (# #{order.id})"
  end

end
