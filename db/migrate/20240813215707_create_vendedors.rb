class CreateVendedors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendedors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :emailParaContato, null: false
      t.integer :totalVendas, null: false
      t.float :nota, default: 0.0

      t.timestamps
    end
  end
end
