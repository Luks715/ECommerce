class CreateClientes < ActiveRecord::Migration[7.1]
  def change
    create_table :clientes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cpf, null: false
      t.decimal :saldo, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
