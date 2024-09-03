class CreateProcedureApagarProduto < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION apagar_produto(produto_apagado_id INT)
      RETURNS VOID AS $$
      BEGIN
        -- Atualiza o saldo dos clientes
        UPDATE clientes c
        SET saldo = saldo + subquery.sub_total
        FROM (
          SELECT pd.cliente_id, SUM(pd.quantidade * (p.preco - (p.preco * p.desconto / 100.0))) AS sub_total
          FROM pedidos pd
          JOIN produtos p ON p.id = pd.produto_id
          WHERE pd.produto_id = produto_apagado_id
            AND pd.foi_pago = TRUE
            AND pd.foi_enviado = FALSE
          GROUP BY pd.cliente_id
        ) AS subquery
        WHERE c.id = subquery.cliente_id;

        -- Atualiza a carteira dos vendedores
        UPDATE vendedors v
        SET carteira = carteira - subquery.sub_total
        FROM (
          SELECT pr.vendedor_id, SUM(pd.quantidade * (p.preco - (p.preco * p.desconto / 100.0))) AS sub_total
          FROM pedidos pd
          JOIN produtos p ON p.id = pd.produto_id
          JOIN produtos pr ON pr.id = p.id
          WHERE pd.produto_id = produto_apagado_id
            AND pd.foi_pago = TRUE
            AND pd.foi_enviado = FALSE
          GROUP BY pr.vendedor_id
        ) AS subquery
        WHERE v.id = subquery.vendedor_id;

        -- Remove os pedidos
        DELETE FROM pedidos
        WHERE produto_id = produto_apagado_id
          AND foi_pago = TRUE
          AND foi_enviado = FALSE;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS apagar_produto(produto_apagado_id INT);
    SQL
  end
end
