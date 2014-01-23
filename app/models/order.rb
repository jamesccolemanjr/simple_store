class Order < ActiveRecord::Base
	belongs_to :address
	has_many :line_items

	CURRENT_SALES_TAX	= 0.06

	def self.sales_tax_in_percent
		return CURRENT_SALES_TAX * 100
	end

	def self.process_order(address, current_cart)
		order = Order.new
	    order.address_id = address.id

	    sub_total = Cart.calculate_cart_total(current_cart)

	    order.sub_total = sub_total
	    order.sales_tax = order.sub_total * Order::CURRENT_SALES_TAX
	    order.grand_total = order.sub_total + order.sales_tax
    
    if order.save
	    current_cart.each do |key, item|
	      line_item = LineItem.new
	      line_item.product_id = key
	      line_item.quantity = item[0]
	      line_item.unit_price = item[2]
	      line_item.line_total = line_item.quantity * line_item.unit_price
	      line_item.order_id = order.id
	      if line_item.save
		      product = Product.find(line_item.product_id)
		      product.ohb = product.ohb - line_item.quantity
		      product.save
		    end
	    end

	  end
	  return order
	end
end
