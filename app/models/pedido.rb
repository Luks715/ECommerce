class Pedido < ApplicationRecord
  belongs_to :carrinho, class_name: "carrinho", foreign_key: "carrinho_id"
  has_one :produto
  validates :quantidade, presence: true

  private

  def subTotal
    return (@produto.preco)*quantidade
  end
end
