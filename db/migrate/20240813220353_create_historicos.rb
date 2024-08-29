class CreateHistoricos < ActiveRecord::Migration[7.1]
  def change
    create_table :historicos do |t|
      t.string :cliente_nome, null: false
      t.string :vendedor_nome, null: false
      t.string :produto_nome, null: false
      t.integer :quantidade, null: false
      t.date :data_compra,    null: false
      t.bool :review_do_produto, null: false
      t.bool :review_do_vendedor, null:false

      t.timestamps
    end
  end
end
