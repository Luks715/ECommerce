class CreatePrecoCompraView < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE VIEW "Preco Compra" AS
        SELECT pr.vendedor_id, pd.quantidade * p.preco AS subtotal
        FROM pedidos pd
        JOIN produtos p ON p.id = pd.produto_id
        JOIN produtos pr ON pr.id = p.id
        WHERE pd.foi_pago = FALSE;
    SQL
  end
end
