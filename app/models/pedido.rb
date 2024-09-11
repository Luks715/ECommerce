class Pedido < ApplicationRecord
  belongs_to :carrinho
  belongs_to :cliente
  belongs_to :produto

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
  validates :foi_pago, inclusion: { in: [true, false] }
  validates :foi_enviado, inclusion: { in: [true, false] }

  def subTotal
    return (self.produto.preco_promocional)*quantidade
  end

  def self.destroy_pedidos(pedidos_ids)
    if pedidos_ids.present?
      # Converte o array de IDs para o formato de array literal do PostgreSQL
      array_literal = "{#{pedidos_ids.join(',')}}"

      # Usa a interpolação segura para garantir a sintaxe correta
      sanitized_ids = ActiveRecord::Base.sanitize_sql_array(["SELECT destroy_pedidos(?)", array_literal])
      ActiveRecord::Base.connection.execute(sanitized_ids)
    else
      false
    end
  end

  def self.enviar(pedidos_ids)
    if pedidos_ids.present?
      array_literal = "{#{pedidos_ids.join(',')}}"

      sanitized_ids = ActiveRecord::Base.sanitize_sql_array(["SELECT update_pedidos_enviados(?)", array_literal])
      ActiveRecord::Base.connection.execute(sanitized_ids)
    else
      false
    end
  end
end
