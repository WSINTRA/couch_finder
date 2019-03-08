class CreateSupplierCouches < ActiveRecord::Migration[5.0]
  def change
  	create_table :supplier_couches do |t|
			t.integer :supplier_id
			t.integer :couch_id
			t.integer :quantity
			t.integer :price
			t.timestamps
		end
  end
end
