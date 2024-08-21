class CreateReviewVendedors < ActiveRecord::Migration[7.1]
  def change
    create_table :review_vendedors do |t|
      t.references :cliente,  null: false, foreign_key: true
      t.references :vendedor, null: false, foreign_key: true

      t.integer :nota, null: false
      t.text :comentario, null: false

      t.timestamps
    end
  end
end
