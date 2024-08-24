class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.references :carrinho, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false

      t.boolean :foi_pago, null: false
      t.boolean :foi_enviado, null: false
      t.date :data_chegada, null: false
      t.timestamps
    end
  end
end
