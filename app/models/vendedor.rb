class Vendedor < ApplicationRecord
  after_initialize :set_default_values, if: :new_record?

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :reviews, dependent: :destroy

  has_many :produtos, dependent: :destroy
  accepts_nested_attributes_for :produtos, reject_if: :all_blank, allow_destroy: true

  validates :emailParaContato, presence: true
  validates :cnpj, uniqueness: true

  def totalVendas
    Historico.where(vendedorNome: self.user.nome).count
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
