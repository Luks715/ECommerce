class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.references :vendedor, null: false, foreign_key: true
      t.references :categorium, null: false, foreign_key: true

      t.string :nome, null: false
      t.text :descricao, null: false
      t.float :nota, default: 0.0
      t.decimal :preco, precision: 10, scale: 2, null: false
      t.integer :emEstoque, null: false
      t.boolean :emPromocao, default: false

      t.timestamps
    end
  end
end
