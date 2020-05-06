class Public::CustomersController < Public::Base
    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        @customer.update(customer_params)
        redirect_to edit_customer_path(@customer)
    end

    private
    def customer_params
        params.require(:customer).permit(:id, :email, :last_name, :first_name, :postcode, :address)
    end
end
