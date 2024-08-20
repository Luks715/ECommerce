class CreateClienteProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :cliente_produtos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
