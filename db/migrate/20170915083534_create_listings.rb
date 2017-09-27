class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name, null: false

      t.integer :bed_number, null: false
      t.integer :bathroom_number, null:false
      t.integer :guest_number, null: false

      t.string :address, null: false
      t.string :city, null: false

      t.integer :price, null: false
      t.text :description

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
