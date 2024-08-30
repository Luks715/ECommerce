CREATE OR REPLACE FUNCTION destroy_pedidos(pedidos_ids BIGINT[], cliente_id BIGINT)
    RETURNS VOID AS $$
    BEGIN
    IF array_length(pedidos_ids, 1) IS NOT NULL THEN
        DELETE FROM pedidos
        WHERE id = ANY(pedidos_ids) AND cliente_id = cliente_id;
    END IF;
    END;
$$ LANGUAGE plpgsql;