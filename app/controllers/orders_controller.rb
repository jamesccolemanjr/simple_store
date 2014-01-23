class OrdersController < ApplicationController
  
  def index
  end

  def new
  		address_num = params[:address_id]
   		@address = Address.find_by_id(params[:address_id])

  	    # create order/line-items from Cart
        current_cart = session[:cart]      
        Order.process_order(@address, current_cart)
        # Clear the session / cart
        session.delete(:cart)

        @order = Order.last

  end

  def show
  end

end
