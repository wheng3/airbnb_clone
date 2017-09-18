class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.string :property_type, null: false

      t.integer :room_type, null: false
      t.integer :room_number, null: false
      t.integer :bed_number, null: false
      t.integer :guest_number, null: false

      t.string :country
      t.string :state
      t.string :city
      t.string :address, null: false

      t.decimal :price, null: false
      t.text :description

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
