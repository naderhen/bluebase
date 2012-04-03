class AddCustomerIdToItem < ActiveRecord::Migration
  def change
  	add_column :items, :customer_id, :integer
  end
end
