class CreateCouches < ActiveRecord::Migration[5.0]
  def change
  	create_table :couches do |t|
			t.string :name
			t.string :functionality
			t.integer :length_in_ft
			t.string :colour
			t.timestamps
		end
  end
end
