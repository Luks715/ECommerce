class CreateProdutoEmPromos < ActiveRecord::Migration[7.1]
  def change
    create_table :produto_em_promos do |t|
      t.references :produto, null: false, foreign_key: true
      t.integer :desconto, null: false
      t.date :dataFim

      t.timestamps
    end
  end
end
