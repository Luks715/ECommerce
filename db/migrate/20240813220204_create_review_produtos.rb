class CreateReviewProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :review_produtos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true

      t.integer :nota, null: false
      t.text :comentario, null: false

      t.timestamps
    end
  end
end
