class CreateOrders < ActiveRecord::Migration[5.2]
  def change
  		create_table :orders do |t|
			t.integer :supplier_couch_id
			t.integer :customer_id
			t.integer :couch_id
			t.timestamps
		end
  end
end
