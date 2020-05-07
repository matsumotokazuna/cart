class Public::OrdersController < Public::Base
    def new
        @order = Order.new
        @customer = Customer.find_by(id: current_customer.id)
        @registered_addresses = ShippingAddress.where(customer_id: current_customer.id)
    end

    def confirm
        @order = Order.new(order_params)
        @customer = Customer.find_by(id: current_customer.id)
        @cart_items = CartItem.all.includes(:item)
        @address_select = params[:address_select]
        @order.carriage = 800
        if @address_select == "ご自身の住所"
            @order.postcode = @customer.postcode
            @order.address = @customer.address
            @order.name = @customer.last_name + @customer.first_name
        elsif @address_select == "登録済住所から選択"
            @order.address
        else
            @order.postcode = params[:new_postcode]
            @order.address = params[:new_address]
            @order.name = params[:new_name]
        end
    end

    def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @order.save
        current_customer.cart_items.each do |cart_item|
            @order_item = OrderItem.new
            @order_item.order_id = @order.id
            @order_item.item_id = cart_item.item_id
            @order_item.order_price = cart_item.item.price
            @order_item.quantity = cart_item.quantity
            @order_item.save
            cart_item.destroy
        end
        redirect_to orders_thanks_path
    end

    def thanks
    end

    def show
        @order = Order.find(params[:id])
        @order_items = OrderItem.where(order_id: @order.id).includes(:item)
        if @order.customer_id == current_customer.id
        else
            redirect_to orders_path
        end
    end

    private
    def order_params
        params.require(:order).permit(:postcode, :address, :name, :payment_method, :carriage, :total_price)
    end

end
