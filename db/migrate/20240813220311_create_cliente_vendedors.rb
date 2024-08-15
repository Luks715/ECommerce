class CreateClienteVendedors < ActiveRecord::Migration[7.1]
  def change
    create_table :cliente_vendedors do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :vendedor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
