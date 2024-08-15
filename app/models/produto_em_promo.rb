class ProdutoEmPromo < ApplicationRecord
  belongs_to :produto, class_name: "Produto", foreign_key: "produto_id"

  validates :desconto, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :dataFim, presence: true

  validate :data_fim_deve_ser_futura

  private

  # Validação personalizada para garantir que a data de término seja no futuro
  def data_fim_deve_ser_futura
    if dataFim.present? && dataFim <= Date.today
      errors.add(:dataFim, "deve ser uma data futura")
    end
  end
end
