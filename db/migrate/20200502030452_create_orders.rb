class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status
      t.integer :customer_id
      t.string :postcode
      t.string :address
      t.string :name
      t.integer :carriage
      t.integer :total_price
      t.integer :payment_method

      t.timestamps
    end
  end
end
