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
end
