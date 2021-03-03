class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :product, foreign_key: true

      t.integer :quantity
      t.string :delivery_address

      t.timestamps
    end
  end
end
