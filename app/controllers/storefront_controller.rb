class StorefrontController < ApplicationController

	def index
		category_num = params[:category_id]

		if category_num.blank?
			@products = Product.where('ohb > 0')
		else
			@products = Category.find(category_num).products
			@description = Category.find(category_num).description
		end

		if session[:cart].nil?
  		  session[:cart] = {}
  		end

  		@cart = session[:cart]

		@categories = Category.all

		@sum = Cart.calculate_cart_total(@cart)
		
	end


	def add_cart
		product_id = params[:product_id]
		quantity = params[:quantity].to_i
		@product_name = params[:product_name]
		price = params[:product_price].to_f

		if session[:cart].nil?
			session[:cart] = {}
		end

		current_cart = session[:cart]

		if current_cart[product_id].nil?
			current_cart[product_id] = [quantity, @product_name, price]
		else
			value_array = current_cart[product_id]
			old_quantity = value_array[0]
			new_quantity = old_quantity + quantity
			current_cart[product_id] = [new_quantity, @product_name, price]
		end

		@cart = current_cart
		Rails.logger.info "CART= #{session[:cart]}"

		@sum = Cart.calculate_cart_total(@cart)

	end

	def remove_cart_item
		product_id = params[:product_id]
		@cart = session[:cart]
		@cart.delete(product_id)

		redirect_to root_path
	end

end
