class Pedido < ApplicationRecord
  belongs_to :cliente
  belongs_to :produto
  validates :quantidade, presence: true

  private

  def subTotal
    return (@produto.preco)*quantidade
  end
end
