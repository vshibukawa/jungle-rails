class OrderReceiptPreview < ApplicationMailer::Preview

  def order_receipt
    order = Order.first
    OrderReceipt.order_receipt order
  end

end
