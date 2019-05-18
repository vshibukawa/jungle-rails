module OrderHelper
  include ActionView::Helpers::TranslationHelper

  def set_html_order_helper(order, url)
    self.html_format set_order_helper(order, url)
  end

  def set_order_helper(order, url)

    content_tag :section, class: "orders-show" do
      header = content_tag :header, class: "page-header" do
        h1 = content_tag :h1, "Order #{order.id}"
        p = content_tag :p, order.email
        h1 + p
      end

      jumbotron = content_tag(:div, class: "order-summary jumbotron") do
        h4 = content_tag(:h4, "Thank you for your order!")
        items = content_tag(:div, class: "panel panel-default items") do
          content_tag(:table, class:"table table-bordered") do
            thead = content_tag(:thead) do
              content_tag(:tr) do
                product_txt = content_tag(:th, "Product", :colspan => 2)
                unit_price_txt = content_tag(:th, "Unit Price")
                quantity_txt = content_tag(:th, "Quantity")
                price_txt = content_tag(:th, "Price")
                product_txt + unit_price_txt + quantity_txt + price_txt
              end
            end

            tbody = content_tag(:tbody) do
              LineItem.where(order_id: order.id).each do |item|
                if items
                  items += set_order_item_helper item
                else
                  items =  set_order_item_helper item
                end
              end
              items
            end

            tfoot = content_tag(:tfoot) do
              content_tag(:tr) do
                total_txt = content_tag(:th, "TOTAL:",:colspan => 4)
                total_value = content_tag(:th, order.total)
                total_txt + total_value
              end
            end

            thead + tbody + tfoot
          end
        end

        h4 + items
      end

      if url
        link = link_to "Go to order", url, class: 'btn btn-lg btn-primary'
      else
        link = link_to "Continue Shopping", root_path, class: 'btn btn-lg btn-primary'
      end

      header + jumbotron + link
    end
  end

  def set_order_item_helper(item)

    content_tag(:article, class: "product") do
      product = Product.find_by id: item.product_id

      content_tag :tr do
        img_tag = content_tag(:td) do
          image_tag product.image.tiny
        end

        product_tag = content_tag(:td) do
          h4 = content_tag(:h4, product.name)
          br = content_tag(:br)
          span = content_tag(:span, product.description)
          h4 + br + span
        end

        price_tag = content_tag(:td, product.price)
        quantity_tag = content_tag(:td, item.quantity)
        total_price_tag = content_tag(:td, item.total_price)

        img_tag + product_tag + price_tag + quantity_tag + total_price_tag
      end
    end
  end

end