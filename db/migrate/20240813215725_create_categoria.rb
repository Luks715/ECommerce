class CreateCategoria < ActiveRecord::Migration[7.1]
  def change
    create_table :categoria do |t|
      t.string :nome, null: false
      t.string :produto_mais_vendido

      t.timestamps
    end
  end
end
