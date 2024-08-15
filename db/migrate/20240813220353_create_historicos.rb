class CreateHistoricos < ActiveRecord::Migration[7.1]
  def change
    create_table :historicos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :pedido, null: false, foreign_key: true
      t.date :dataDeCompra, null: false

      t.timestamps
    end
  end
end
