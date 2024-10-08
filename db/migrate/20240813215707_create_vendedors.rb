class CreateVendedors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendedors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cnpj, null: false
      t.string :email_para_contato, null: false
      t.decimal :carteira, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
