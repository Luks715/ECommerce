class CreateHistoricos < ActiveRecord::Migration[7.1]
  def change
    create_table :historicos do |t|
      t.string :clienteNome, null: false
      t.string :vendedorNome, null: false
      t.string :produtoNome, null: false
      t.integer :quantidade, null: false
      t.date :dataCompra,    null: false

      t.timestamps
    end
  end
end
