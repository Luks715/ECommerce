class CreateProcedureUpdatePedidosEnviados < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION update_pedidos_enviados(pedidos_ids BIGINT[])
      RETURNS VOID AS $$
      BEGIN
        IF array_length(pedidos_ids, 1) IS NOT NULL THEN
            UPDATE pedidos
            SET foi_enviado = true
            WHERE id = ANY(pedidos_ids);
        END IF;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end
end