class Public::CartItemsController < Public::Base
    def create
        cart_items = CartItem.all
        isExist = false
        id = 0
        cart_items.each do |cart_item|
            if cart_item.customer_id == current_customer.id
                if cart_item.item_id == cart_item_params[:item_id].to_i
                isExist = true
                id = cart_item.id
                end
            end
        end
        if isExist
            cart_item = CartItem.find(id)
            sum = cart_item.quantity.to_i + cart_item_params[:quantity].to_i
            cart_item.update_attributes(quantity: sum)
            redirect_to item_path(cart_item.item_id)
        else
            cart_item = CartItem.new(cart_item_params)
            cart_item.customer_id = current_customer.id
            cart_item.save
            redirect_to item_path(cart_item.item_id)
        end
    end

    def index
        @cart_items = CartItem.all.includes(:item)
    end

    def update
        @cart_item = CartItem.find(params[:id])
        if @cart_item.update(cart_item_params)
            redirect_to cart_items_path
        else
            @cart_items = CartItem.all.includes(:item)
            render 'index'
        end
    end

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path
    end

    def destroy_all
        @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.destroy_all
        redirect_to cart_items_path
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :quantity)
    end
end
