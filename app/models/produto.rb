class Produto < ApplicationRecord
  belongs_to :vendedor, class_name: "Vendedor", foreign_key: "vendedor_id"
  belongs_to :categorium, class_name: "Categorium", foreign_key: "categorium_id"
  has_many :reviews

  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, presence: true
  validates :emEstoque, presence: true

  validates :desconto, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validate :data_fim_deve_ser_futura, if: -> { dataFim.present? }

  def preco_promocional
    if self.emPromocao
      preco * (1 - desconto / 100.0)
    else
      self.update(desconto: 0, dataFim: nil)
      preco
    end
  end

  def emPromocao
    (desconto > 0) && dataFim.present? && (Date.today <= dataFim)
  end

  def nota
    if reviews.any?
      somaNotas = reviews.sum(:nota)
      nota = somaNotas / reviews.count.to_f
    else
      nota = 0
    end
    nota.round(1)
  end

  def data_fim_deve_ser_futura
    if dataFim <= Date.today
      errors.add(:dataFim, "deve ser uma data futura.")
    end
  end
end
