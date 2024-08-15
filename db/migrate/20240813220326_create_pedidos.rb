class CreatePedidos < ActiveRecord::Migration[7.1]
  def change
    create_table :pedidos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false

      t.timestamps
    end
  end
end
