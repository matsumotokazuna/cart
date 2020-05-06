class Public::ShippingAddressesController < Public::Base
    def index
        @shipping_address = ShippingAddress.new
        @shipping_addresses = ShippingAddress.all
    end

    def create
        @shipping_address = ShippingAddress.new(shipping_address_params)
        @shipping_address.customer_id = current_customer.id
        @shipping_address.save
        redirect_to shipping_addresses_path
    end

    private
    def shipping_address_params
        params.require(:shipping_address).permit(:postcode, :address, :name)
    end
end
