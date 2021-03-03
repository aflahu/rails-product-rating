class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :purchase, foreign_key: true

      t.integer :rating
      t.string :comment

      t.timestamps
    end
  end
end
