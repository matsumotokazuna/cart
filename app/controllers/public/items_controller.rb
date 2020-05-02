class Public::ItemsController < Public::Base
    def index
        @item = Item.new
        @items = Item.all
        @cart = CartItem
    end

    def create
        @item = Item.new(item_params)
        @item.save
        redirect_to items_path
    end

    def show
        @item = Item.find(params[:id])
        @cart = CartItem.new
    end

    private
    def item_params
        params.require(:item).permit(:name, :price)
    end
end
