class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :nome, null: false
      t.string :telefone, null: false
      t.string :endereco, null: false
      t.integer :role, default: 0, null: false

      t.binary :imagem

      t.timestamps
    end
  end
end
