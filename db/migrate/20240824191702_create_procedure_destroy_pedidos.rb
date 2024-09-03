class CreateProcedureDestroyPedidos < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION destroy_pedidos(pedidos_ids BIGINT[])
      RETURNS VOID AS $$
      BEGIN
        IF array_length(pedidos_ids, 1) IS NOT NULL THEN
          DELETE FROM pedidos
          WHERE id = ANY(pedidos_ids);
        END IF;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end
end
