class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.references :carrinho, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false

      t.boolean :foiPago, null: false
      t.boolean :foiEnviado, null: false
      t.date :dataChegada, null: false
      t.timestamps
    end
  end
end
