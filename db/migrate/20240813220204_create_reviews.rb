class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, foreign_key: true
      t.references :vendedor, foreign_key: true
      t.integer :nota, null: false
      t.text :comentario

      t.timestamps
    end
  end
end
