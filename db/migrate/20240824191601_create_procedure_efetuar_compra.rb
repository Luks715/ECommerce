class CreateProcedureEfetuarCompra < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION efetuar_compra(id_do_cliente INT, novo_saldo NUMERIC)
      RETURNS VOID AS $$
      BEGIN
          -- Atualiza o estoque dos produtos
          UPDATE produtos p
          SET em_estoque = p.em_estoque - pd.quantidade
          FROM pedidos pd
          WHERE pd.produto_id = p.id
            AND pd.cliente_id = id_do_cliente
            AND pd.foi_pago = FALSE;

          -- Atualiza a carteira dos vendedores
          UPDATE vendedors v
          SET carteira = v.carteira + subquery.subtotal
          FROM (
              SELECT pr.vendedor_id, pd.quantidade * pr.preco AS subtotal
              FROM pedidos pd
              JOIN produtos pr ON pr.id = pd.produto_id
              WHERE pd.cliente_id = id_do_cliente
                AND pd.foi_pago = FALSE
          ) AS subquery
          WHERE v.id = subquery.vendedor_id;

          -- Marca os pedidos como pagos
          UPDATE pedidos
          SET foi_pago = TRUE,
              data_chegada = CURRENT_DATE + INTERVAL '14 days'
          WHERE cliente_id = id_do_cliente
            AND foi_pago = FALSE;

          -- Atualiza os pedidos com o ID do carrinho do vendedor
          UPDATE pedidos p
          SET carrinho_id = (
            SELECT c.id
            FROM carrinhos c
            JOIN vendedors v ON v.user_id = c.user_id
            JOIN produtos pr ON pr.vendedor_id = v.id
            WHERE pr.id = p.produto_id
            LIMIT 1  -- Certifica-se de pegar apenas um carrinho
          )
          WHERE p.cliente_id = id_do_cliente
            AND p.foi_pago = TRUE;

          -- Cria histórico
          INSERT INTO historicos(cliente_nome, vendedor_nome, produto_nome, quantidade, data_compra, review_do_vendedor, review_do_produto, created_at, updated_at)
          SELECT u.nome, vu.nome, p.nome, pd.quantidade, CURRENT_DATE, FALSE, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
          FROM pedidos pd
          JOIN produtos p ON p.id = pd.produto_id
          JOIN users u ON u.id = pd.cliente_id
          JOIN vendedors v ON v.id = p.vendedor_id
          JOIN users vu ON vu.id = v.user_id
          WHERE pd.cliente_id = id_do_cliente;

          -- Atualiza saldo do cliente
          UPDATE clientes
          SET saldo = novo_saldo
          WHERE user_id = id_do_cliente;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS efetuar_compra(id_do_cliente INT, novo_saldo NUMERIC);
    SQL
  end
end
