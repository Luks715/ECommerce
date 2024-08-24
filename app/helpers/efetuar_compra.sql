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
        SELECT pr.vendedor_id, pd.quantidade * p.preco AS subtotal
        FROM pedidos pd
        JOIN produtos p ON p.id = pd.produto_id
        JOIN produtos pr ON pr.id = p.id
        WHERE pd.cliente_id = id_do_cliente
          AND pd.foi_pago = FALSE
    ) AS subquery
    WHERE v.id = subquery.vendedor_id;

    -- Atualiza os pedidos com o ID do carrinho do vendedor
    UPDATE pedidos p
    SET carrinho_id = c.id
    FROM carrinhos c
    WHERE c.user_id = (
        SELECT pr.vendedor_id
        FROM produtos pr
        WHERE pr.id = p.produto_id
    )
      AND p.cliente_id = id_do_cliente
      AND p.foi_pago = FALSE;

    -- Marca os pedidos como pagos e cria registros adicionais
    UPDATE pedidos
    SET foi_pago = TRUE, 
        data_chegada = CURRENT_DATE + INTERVAL '14 days'
    WHERE cliente_id = id_do_cliente
      AND foi_pago = FALSE;

    -- Cria registros em ClienteVendedor e ClienteProduto
    INSERT INTO cliente_vendedors(cliente_id, vendedor_id, created_at, updated_at)
    SELECT DISTINCT id_do_cliente, pr.vendedor_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
    FROM pedidos p
    JOIN produtos pr ON pr.id = p.produto_id
    WHERE p.cliente_id = id_do_cliente;

    INSERT INTO cliente_produtos(cliente_id, produto_id, created_at, updated_at)
    SELECT DISTINCT id_do_cliente, produto_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
    FROM pedidos
    WHERE cliente_id = id_do_cliente;

    -- Cria histórico
    INSERT INTO historicos(cliente_nome, vendedor_nome, produto_nome, quantidade, data_compra, created_at, updated_at)
    SELECT u.nome, vu.nome, p.nome, pd.quantidade, CURRENT_DATE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
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
