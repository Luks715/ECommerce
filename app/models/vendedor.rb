class Vendedor < ApplicationRecord
  after_initialize :set_default_values, if: :new_record?

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :produtos, dependent: :destroy
  accepts_nested_attributes_for :produtos, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  has_many :reviews

  validates :emailParaContato, presence: true

  def totalVendas
    Pedido.where(carrinho: self.user.carrinho).count
  end

  def calcular_nota
    relevant_reviews = reviews.where(produto_id: nil)
    if relevant_reviews.any?
      somaNotas = relevant_reviews.sum(:nota)
      nota = somaNotas / relevant_reviews.count.to_f
      nota.round(1)
    else
      0.0
    end
  end

  private

  def set_default_values
    self.carteira ||= 0.0
  end
end
